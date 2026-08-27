#!/usr/bin/env python3
"""List what an ELF32 shared object exports, and demangle it.

The port has to link against two libraries it cannot rebuild: libheaven.so is
the server-side network engine and librainbow.so the client-side one, both
shipped as i386 objects with no headers. Their dynamic symbol tables are the
only written-down part of that ABI, so this reads them directly.

`nm -D --defined-only` does the same job, but the dev host has no binutils --
and the parse is thirty lines, because a dynamic symbol table is exactly as
regular as it looks: DT_SYMTAB, DT_STRTAB, and a count that has to be recovered
from DT_HASH or DT_GNU_HASH since ELF does not store one.

    python3 tools/elf_exports.py server1/libheaven.so [--all]
"""
from __future__ import annotations

import argparse
import struct
import sys

STT = {0: "NOTYPE", 1: "OBJECT", 2: "FUNC", 3: "SECTION", 4: "FILE",
       6: "TLS", 10: "GNU_IFUNC"}
STB = {0: "LOCAL", 1: "GLOBAL", 2: "WEAK"}

DT_HASH, DT_STRTAB, DT_SYMTAB, DT_STRSZ, DT_SYMENT, DT_GNU_HASH = 4, 5, 6, 10, 11, 0x6FFFFEF5


def demangle(sym: str) -> str:
    """Enough Itanium ABI for the shapes these two libraries actually export.

    Names only -- no parameter types. `CreateServer(unsigned, unsigned,
    IServer**)` comes back as `CreateServer`, which is what a symbol table is
    being asked for here. Anything unrecognised is returned unchanged rather
    than guessed at.
    """
    if not sym.startswith("_Z"):
        return sym
    i = 2
    nested = i < len(sym) and sym[i] == "N"
    if nested:
        i += 1
    parts = []
    while i < len(sym) and sym[i].isdigit():
        j = i
        while j < len(sym) and sym[j].isdigit():
            j += 1
        n = int(sym[i:j])
        parts.append(sym[j:j + n])
        i = j + n
        if not nested:
            break
    return "::".join(parts) if parts else sym


def sections(data: bytes) -> "dict[str, tuple[int, int, int]]":
    """name -> (file offset, size, entry size), from the section headers."""
    e_shoff, = struct.unpack_from("<I", data, 0x20)
    e_shentsize, e_shnum, e_shstrndx = struct.unpack_from("<HHH", data, 0x2E)
    if not e_shoff:
        return {}
    base = e_shoff + e_shstrndx * e_shentsize
    str_off, str_size = struct.unpack_from("<II", data, base + 0x10)
    names = data[str_off:str_off + str_size]

    out = {}
    for k in range(e_shnum):
        sh = e_shoff + k * e_shentsize
        sh_name, = struct.unpack_from("<I", data, sh)
        sh_offset, sh_size = struct.unpack_from("<II", data, sh + 0x10)
        sh_entsize, = struct.unpack_from("<I", data, sh + 0x24)
        end = names.find(b"\0", sh_name)
        out[names[sh_name:end].decode()] = (sh_offset, sh_size, sh_entsize)
    return out


def dynamic_symbols(data: bytes) -> "list[tuple[str, int, int, int, int]]":
    """(name, value, size, type, bind) for every entry in .dynsym.

    Prefers the section headers, which give the table's size outright. Falls
    back to walking DT_HASH's chain count when they have been stripped -- a
    stripped .so still has to keep .dynsym for the loader, just not a header
    describing it.
    """
    secs = sections(data)
    if ".dynsym" in secs and ".dynstr" in secs:
        sym_off, sym_size, entsize = secs[".dynsym"]
        str_off, str_size, _ = secs[".dynstr"]
        count = sym_size // (entsize or 16)
    else:
        e_phoff, = struct.unpack_from("<I", data, 0x1C)
        e_phentsize, e_phnum = struct.unpack_from("<HH", data, 0x2A)
        dyn = None
        for k in range(e_phnum):
            ph = e_phoff + k * e_phentsize
            p_type, p_offset = struct.unpack_from("<II", data, ph)
            if p_type == 2:            # PT_DYNAMIC
                dyn = p_offset
                break
        if dyn is None:
            sys.exit("no .dynsym and no PT_DYNAMIC: not a shared object?")

        tags = {}
        off = dyn
        while True:
            tag, val = struct.unpack_from("<Ii", data, off)
            if tag == 0:
                break
            tags[tag] = val & 0xFFFFFFFF
            off += 8

        # Virtual addresses in the dynamic section; map them back through the
        # program headers to file offsets.
        def to_off(vaddr: int) -> int:
            for k in range(e_phnum):
                ph = e_phoff + k * e_phentsize
                p_type, p_offset, p_vaddr = struct.unpack_from("<III", data, ph)
                p_filesz, = struct.unpack_from("<I", data, ph + 0x10)
                if p_type == 1 and p_vaddr <= vaddr < p_vaddr + p_filesz:
                    return p_offset + (vaddr - p_vaddr)
            sys.exit(f"vaddr {vaddr:#x} is in no PT_LOAD")

        sym_off = to_off(tags[DT_SYMTAB])
        str_off = to_off(tags[DT_STRTAB])
        str_size = tags.get(DT_STRSZ, 0)
        entsize = tags.get(DT_SYMENT, 16)
        # nchain in DT_HASH is the symbol count, by definition.
        h = to_off(tags[DT_HASH])
        count, = struct.unpack_from("<I", data, h + 4)

    strtab = data[str_off:str_off + str_size]
    out = []
    for k in range(count):
        e = sym_off + k * entsize
        st_name, st_value, st_size, st_info, _st_other, st_shndx = \
            struct.unpack_from("<IIIBBH", data, e)
        if not st_name:
            continue
        end = strtab.find(b"\0", st_name)
        name = strtab[st_name:end].decode("utf-8", "replace")
        out.append((name, st_value, st_size, st_info & 0xF, st_info >> 4, st_shndx))
    return out


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("so", help="the shared object to read")
    ap.add_argument("--all", action="store_true",
                    help="include undefined symbols (the ones it imports)")
    ap.add_argument("--filter", help="substring the demangled name must contain")
    args = ap.parse_args()

    data = open(args.so, "rb").read()
    if data[:4] != b"\x7fELF" or data[4] != 1:
        sys.exit(f"{args.so} is not an ELF32 file")

    rows = dynamic_symbols(data)
    shown = 0
    print("value\tsize\ttype\tbind\tsymbol\tdemangled")
    for name, value, size, typ, bind, shndx in rows:
        defined = shndx != 0
        if not defined and not args.all:
            continue
        pretty = demangle(name)
        if args.filter and args.filter not in pretty:
            continue
        shown += 1
        print("%08x\t%d\t%s\t%s\t%s\t%s"
              % (value, size, STT.get(typ, str(typ)), STB.get(bind, str(bind)),
                 name, pretty if pretty != name else ""))

    total = len(rows)
    defined = sum(1 for r in rows if r[5] != 0)
    print(f"# {shown} shown; {defined} defined, {total - defined} imported, "
          f"{total} in .dynsym", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
