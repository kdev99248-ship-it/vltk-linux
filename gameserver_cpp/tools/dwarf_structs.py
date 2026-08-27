#!/usr/bin/env python3
"""Read struct layouts straight out of the shipped binary's DWARF.

`server1/jx_linux_y` was built with `-g` and never stripped: it carries 21 MB of
.debug_info. That makes it self-describing. Every struct it uses is recorded with
its exact byte size and the offset of every member, exactly as the compiler that
produced the running server laid it out.

This is the ground truth the Phase 0 exit criterion asks for, and it is stronger
than the alternative. Capturing live traffic only reveals the total length of the
packets a session happens to send; DWARF gives the size AND the internal layout
of every struct, including the ones no session touches. It needs no client, no
server, and no network.

Usage:
    # size table for every struct the binary knows about
    python3 tools/dwarf_structs.py server1/jx_linux_y -o protocol/binary_sizes.tsv

    # compare against what our build produces  (exit 1 on any mismatch)
    python3 tools/dwarf_structs.py server1/jx_linux_y \\
        --compare protocol/struct_sizes.tsv

    # field-by-field layout of one struct
    python3 tools/dwarf_structs.py server1/jx_linux_y --members PLAYER_SYNC
"""
import argparse
import struct
import sys

# --- DWARF 2 constants, only the ones this needs -------------------------------
TAG_array = 0x01
TAG_class = 0x02
TAG_enum = 0x04
TAG_member = 0x0D
TAG_pointer = 0x0F
TAG_structure = 0x13
TAG_typedef = 0x16
TAG_union = 0x17
TAG_inheritance = 0x1C
TAG_subrange = 0x21
TAG_base = 0x24
TAG_const = 0x26
TAG_enumerator = 0x28
TAG_volatile = 0x35

AT_name = 0x03
AT_byte_size = 0x0B
AT_const_value = 0x1C
AT_upper_bound = 0x2F
AT_data_member_location = 0x38
AT_type = 0x49
AT_declaration = 0x3C

WANTED_ATTRS = frozenset((AT_name, AT_byte_size, AT_const_value, AT_upper_bound,
                          AT_data_member_location, AT_type, AT_declaration))

KIND = {TAG_structure: "struct", TAG_union: "union",
        TAG_class: "class", TAG_enum: "enum"}

AGGREGATE = (TAG_structure, TAG_union, TAG_class)
# Only what a typedef chain can pass through on its way to a layout. Keeping
# pointers, arrays and base types too would triple the per-CU dictionary for no
# gain -- a typedef that lands on one of those has no struct layout to report.
KEEP = frozenset(AGGREGATE + (TAG_typedef, TAG_const, TAG_volatile))
# Layout mode additionally needs the DIEs a member's type can point at, so field
# types can be named and sized.
KEEP_FULL = KEEP | frozenset((TAG_base, TAG_pointer, TAG_array, TAG_enum))
# Both attach to the enclosing aggregate. Inheritance is not optional decoration:
# every JX packet derives from a 1-byte protocol-type base, so a layout that
# skips it is missing the byte at offset 0.
CHILD_TAGS = frozenset((TAG_member, TAG_inheritance))

# Forms whose encoded length does not depend on the value. Everything else
# (blocks, strings, LEB128) has to be decoded to find its end.
FIXED_FORM = {
    0x05: 2, 0x06: 4, 0x07: 8, 0x0B: 1, 0x0C: 1, 0x0E: 4,
    0x10: 4, 0x11: 1, 0x12: 2, 0x13: 4, 0x14: 8, 0x17: 4, 0x19: 0,
}


def read_sections(path):
    """Return {name: bytes} for the .debug_* sections, via the section headers."""
    with open(path, "rb") as fh:
        data = fh.read()
    if data[:4] != b"\x7fELF" or data[4] != 1:
        sys.exit(f"{path}: not an ELF32 file")
    shoff, = struct.unpack_from("<I", data, 0x20)
    shentsize, shnum, shstrndx = struct.unpack_from("<HHH", data, 0x2E)

    def sh(i):
        return struct.unpack_from("<10I", data, shoff + i * shentsize)

    _, _, _, _, stro, strsz, *_ = sh(shstrndx)
    names = data[stro:stro + strsz]
    out = {}
    for i in range(shnum):
        nameoff, _t, _f, _a, off, size, *_ = sh(i)
        n = names[nameoff:names.index(b"\x00", nameoff)].decode()
        if n.startswith(".debug_"):
            out[n] = data[off:off + size]
    return out


def uleb(buf, pos):
    result = shift = 0
    while True:
        b = buf[pos]
        pos += 1
        result |= (b & 0x7F) << shift
        if not b & 0x80:
            return result, pos
        shift += 7


def skip_leb(buf, pos):
    while buf[pos] & 0x80:
        pos += 1
    return pos + 1


def parse_abbrev(buf, offset, addr_size):
    """Return {code: (tag, has_children, attrs, fixed_len)}.

    `fixed_len` is the total encoded size of the attributes when every form is
    fixed-width, else None. Most DIEs in a 21 MB .debug_info are subprograms and
    variables we do not care about; being able to skip them with one addition
    instead of a per-attribute decode is what makes this finish quickly.
    """
    table = {}
    pos = offset
    while pos < len(buf):
        code, pos = uleb(buf, pos)
        if code == 0:
            break
        tag, pos = uleb(buf, pos)
        has_children = buf[pos]
        pos += 1
        attrs = []
        while True:
            at, pos = uleb(buf, pos)
            form, pos = uleb(buf, pos)
            if at == 0 and form == 0:
                break
            attrs.append((at, form))
        total = 0
        for _at, form in attrs:
            n = addr_size if form == 0x01 else FIXED_FORM.get(form)
            if n is None:
                total = None
                break
            total += n
        table[code] = (tag, has_children, attrs, total)
    return table


def read_form(buf, pos, form, addr_size, cu_start, debug_str):
    if form == 0x01:                                  # addr
        return struct.unpack_from("<I", buf, pos)[0], pos + addr_size
    if form == 0x03:                                  # block2
        n = struct.unpack_from("<H", buf, pos)[0]
        return buf[pos + 2:pos + 2 + n], pos + 2 + n
    if form == 0x04:                                  # block4
        n = struct.unpack_from("<I", buf, pos)[0]
        return buf[pos + 4:pos + 4 + n], pos + 4 + n
    if form == 0x05:                                  # data2
        return struct.unpack_from("<H", buf, pos)[0], pos + 2
    if form == 0x06:                                  # data4
        return struct.unpack_from("<I", buf, pos)[0], pos + 4
    if form == 0x07:                                  # data8
        return struct.unpack_from("<Q", buf, pos)[0], pos + 8
    if form == 0x08:                                  # string (inline)
        end = buf.index(b"\x00", pos)
        return buf[pos:end], end + 1
    if form == 0x09:                                  # block
        n, pos = uleb(buf, pos)
        return buf[pos:pos + n], pos + n
    if form == 0x0A:                                  # block1
        n = buf[pos]
        return buf[pos + 1:pos + 1 + n], pos + 1 + n
    if form == 0x0B:                                  # data1
        return buf[pos], pos + 1
    if form == 0x0C:                                  # flag
        return buf[pos], pos + 1
    if form == 0x0D:                                  # sdata
        result = shift = 0
        while True:
            b = buf[pos]
            pos += 1
            result |= (b & 0x7F) << shift
            shift += 7
            if not b & 0x80:
                if b & 0x40:
                    result -= 1 << shift
                return result, pos
    if form == 0x0E:                                  # strp
        off = struct.unpack_from("<I", buf, pos)[0]
        end = debug_str.index(b"\x00", off)
        return debug_str[off:end], pos + 4
    if form == 0x0F:                                  # udata
        return uleb(buf, pos)
    if form == 0x10:                                  # ref_addr (section-relative)
        return struct.unpack_from("<I", buf, pos)[0], pos + 4
    if form == 0x11:                                  # ref1
        return cu_start + buf[pos], pos + 1
    if form == 0x12:                                  # ref2
        return cu_start + struct.unpack_from("<H", buf, pos)[0], pos + 2
    if form == 0x13:                                  # ref4
        return cu_start + struct.unpack_from("<I", buf, pos)[0], pos + 4
    if form == 0x14:                                  # ref8
        return cu_start + struct.unpack_from("<Q", buf, pos)[0], pos + 8
    if form == 0x15:                                  # ref_udata
        v, pos = uleb(buf, pos)
        return cu_start + v, pos
    if form == 0x17:                                  # sec_offset (DWARF 4)
        return struct.unpack_from("<I", buf, pos)[0], pos + 4
    if form == 0x18:                                  # exprloc
        n, pos = uleb(buf, pos)
        return buf[pos:pos + n], pos + n
    if form == 0x19:                                  # flag_present
        return 1, pos
    raise ValueError(f"unhandled DW_FORM {form:#x} at {pos:#x}")


def skip_form(buf, pos, form, addr_size):
    """Advance past one attribute without building its value."""
    n = addr_size if form == 0x01 else FIXED_FORM.get(form)
    if n is not None:
        return pos + n
    if form == 0x03:
        return pos + 2 + struct.unpack_from("<H", buf, pos)[0]
    if form == 0x04:
        return pos + 4 + struct.unpack_from("<I", buf, pos)[0]
    if form == 0x08:
        return buf.index(b"\x00", pos) + 1
    if form in (0x09, 0x18):
        n, pos = uleb(buf, pos)
        return pos + n
    if form == 0x0A:
        return pos + 1 + buf[pos]
    if form in (0x0D, 0x0F, 0x15):
        return skip_leb(buf, pos)
    raise ValueError(f"unhandled DW_FORM {form:#x} at {pos:#x}")


def member_offset(expr):
    """DWARF 2 stores member offsets as a location expression, not a constant.

    GCC emits `DW_OP_plus_uconst <n>` (0x23 followed by a ULEB). Later DWARF
    allows a bare constant, which arrives here as an int. Anything else is a
    layout this cannot read, and is reported as `?` rather than guessed at.
    """
    if isinstance(expr, int):
        return expr
    if isinstance(expr, (bytes, bytearray)) and expr and expr[0] == 0x23:
        n, _ = uleb(expr, 1)
        return n
    return None


class Die:
    __slots__ = ("tag", "name", "size", "type", "decl", "fields", "loc", "ub",
                 "val")

    def __init__(self, tag):
        self.tag = tag
        self.name = None
        self.size = None
        self.type = None
        self.decl = False
        self.fields = None   # aggregates: [(name, offset, type_ref)] once wanted
        self.loc = None      # members: the raw DW_AT_data_member_location
        self.ub = None       # subranges: DW_AT_upper_bound, for array counts
        self.val = None      # enumerators: DW_AT_const_value


def type_name(ref, local, depth=0, rename=None):
    """Render a member's type as C-ish source. Best effort, never raises.

    `rename` maps a DIE offset to the name minted for an aggregate GCC left
    anonymous, so the rendered type matches what the type table declares.
    """
    if ref is None:
        return "void"
    t = local.get(ref)
    if t is None or depth > 12:
        return f"<{ref:#x}>"
    if t.tag == TAG_pointer:
        return type_name(t.type, local, depth + 1, rename) + "*"
    if t.tag == TAG_const:
        return "const " + type_name(t.type, local, depth + 1, rename)
    if t.tag == TAG_volatile:
        return "volatile " + type_name(t.type, local, depth + 1, rename)
    if t.tag == TAG_array:
        n = array_count(t)
        inner = type_name(t.type, local, depth + 1, rename)
        return f"{inner}[{'' if n is None else n}]"
    if rename and ref in rename:
        return rename[ref]
    if t.name:
        return t.name
    return {TAG_structure: "struct <anon>", TAG_union: "union <anon>",
            TAG_class: "class <anon>", TAG_enum: "enum <anon>"}.get(t.tag, "?")


def array_count(t):
    """Element count of an array DIE, or None for a flexible array.

    GCC records the extent as a subrange child carrying DW_AT_upper_bound. When
    the bound is absent the array is unsized -- the trailing `BYTE data[]` that
    JX uses for variable-length packets, which contributes zero to sizeof.
    """
    if not t.fields:
        return None
    ub = t.fields[0][1]
    return None if ub is None else ub + 1


def type_size(ref, local, depth=0):
    """Byte size of a type, or None when it cannot be determined."""
    if ref is None or depth > 12:
        return None
    t = local.get(ref)
    if t is None:
        return None
    if t.tag == TAG_pointer:
        return 4
    if t.tag in (TAG_const, TAG_volatile, TAG_typedef):
        return type_size(t.type, local, depth + 1)
    if t.tag == TAG_array:
        n = array_count(t)
        e = type_size(t.type, local, depth + 1)
        return None if (n is None or e is None) else n * e
    return t.size


def walk(sections, want=(), progress=True, packet_bases=None, all_enums=False):
    """Walk every CU.

    Returns (sizes, conflicts, layouts, packets, types, enums):
      sizes     {name: byte_size}
      conflicts {name: {size, ...}} for names the binary defines inconsistently
      layouts   {name: [(member, offset, type, size), ...]} for names in `want`
      packets   {name: (alias, base, kind, size, fields)} for every aggregate
                deriving from one of `packet_bases` -- the real packet set
      types     the same, for every aggregate reachable from a packet field.
                A packet header is not usable without these: a packet whose
                field is `KZhaoMuInfo` does not compile until KZhaoMuInfo does.
      enums     {name: (size, [(enumerator, value), ...])} reachable likewise
    """
    info = sections[".debug_info"]
    abbrev_sec = sections[".debug_abbrev"]
    dstr = sections.get(".debug_str", b"")
    want = set(want)
    find_packets = bool(packet_bases)
    collect_fields = bool(want) or find_packets or all_enums
    keep = KEEP_FULL if collect_fields else KEEP

    abbrev_cache = {}
    sizes, seen, layouts, packets = {}, {}, {}, {}
    types, enums = {}, {}

    pos, total, ncu = 0, len(info), 0
    while pos < total:
        cu_start = pos
        unit_len, _ver, ab_off, addr_size = struct.unpack_from("<IHIB", info, pos)
        cu_end = pos + 4 + unit_len
        pos += 11

        key = (ab_off, addr_size)
        abbrevs = abbrev_cache.get(key)
        if abbrevs is None:
            abbrevs = abbrev_cache[key] = parse_abbrev(abbrev_sec, ab_off, addr_size)

        local = {}     # .debug_info offset -> Die, for typedef resolution
        stack = []     # enclosing DIEs, so members attach to their aggregate

        while pos < cu_end:
            die_off = pos
            code, pos = uleb(info, pos)
            if code == 0:
                if stack:
                    stack.pop()
                continue
            tag, has_children, attrs, fixed_len = abbrevs[code]

            if tag in keep:
                die = Die(tag)
            elif (tag in CHILD_TAGS or
                  (collect_fields and tag in (TAG_subrange, TAG_enumerator))) \
                    and stack and stack[-1] is not None \
                    and stack[-1].fields is not None:
                die = Die(tag)
            else:
                # Nothing here is wanted. Skip the payload outright when every
                # form is fixed-width, which is the common case.
                die = None
                if fixed_len is not None:
                    pos += fixed_len
                else:
                    for _at, form in attrs:
                        if form == 0x16:
                            form, pos = uleb(info, pos)
                        pos = skip_form(info, pos, form, addr_size)
                if has_children:
                    stack.append(None)
                continue

            for at, form in attrs:
                if form == 0x16:                       # indirect
                    form, pos = uleb(info, pos)
                if at not in WANTED_ATTRS:
                    pos = skip_form(info, pos, form, addr_size)
                    continue
                val, pos = read_form(info, pos, form, addr_size, cu_start, dstr)
                if at == AT_name:
                    die.name = (val.decode("latin-1")
                                if isinstance(val, (bytes, bytearray)) else val)
                elif at == AT_byte_size:
                    die.size = val
                elif at == AT_type:
                    die.type = val
                elif at == AT_declaration:
                    die.decl = bool(val)
                elif at == AT_upper_bound:
                    die.ub = val
                elif at == AT_const_value:
                    die.val = val
                else:
                    die.loc = val

            if tag == TAG_subrange:
                # Parked in the array DIE's field list; array_count() reads it.
                stack[-1].fields.append((None, die.ub, None))
            elif tag == TAG_enumerator:
                stack[-1].fields.append((die.name, die.val, None))
            elif tag in CHILD_TAGS:
                name = die.name if tag == TAG_member else "(base)"
                stack[-1].fields.append((name, member_offset(die.loc), die.type))
            else:
                local[die_off] = die
                if tag in AGGREGATE and die.size is not None and not die.decl:
                    if die.name:
                        record(sizes, seen, die.name, die.size)
                if collect_fields and (tag in (TAG_array, TAG_enum) or
                                       (tag in AGGREGATE and not die.decl)):
                    # Anonymous aggregates are the dominant form here
                    # (`typedef struct {...} NAME;`), so field collection cannot
                    # be gated on the name -- it is the typedef that carries it.
                    die.fields = []

            if has_children:
                stack.append(die)

        # Resolve typedefs within the CU. Without this most packet names would
        # not appear at all: they name an otherwise anonymous struct.
        for die in local.values():
            if die.tag != TAG_typedef or not die.name:
                continue
            target, hops = die.type, 0
            while target is not None and hops < 16:
                t = local.get(target)
                if t is None:
                    break
                if t.tag in AGGREGATE:
                    if t.size is not None:
                        record(sizes, seen, die.name, t.size)
                        if die.name in want and t.fields:
                            layouts.setdefault(die.name, resolve(t.fields, local))
                    break
                if t.tag in (TAG_const, TAG_volatile):
                    target, hops = t.type, hops + 1
                    continue
                break

        if collect_fields:
            # typedef offset -> the aggregate it names, so a packet found by its
            # tag name can also report the plain name the code actually uses.
            alias = {}
            if find_packets:
                for die in local.values():
                    if die.tag == TAG_typedef and die.name and die.type is not None:
                        alias.setdefault(die.type, die.name)

            found = []            # (name, off, die, base) for this CU's packets
            for off, die in local.items():
                if all_enums and die.tag == TAG_enum and die.name and die.fields:
                    enums.setdefault(die.name, (die.size, list(die.fields)))
                if die.tag not in AGGREGATE or not die.fields:
                    continue
                if die.name in want:
                    layouts.setdefault(die.name, resolve(die.fields, local))
                if not find_packets or die.size is None:
                    continue
                # A packet is any struct inheriting from a protocol header base.
                # That is the binary's own definition of the set, which is why
                # it finds packets the Windows headers never had.
                first = die.fields[0]
                if first[0] != "(base)":
                    continue
                base = type_name(first[2], local)
                if base not in packet_bases:
                    continue
                key = die.name or alias.get(off)
                if key:
                    found.append((key, off, die, base))

            if found:
                closure, rename = walk_closure(found, local, alias)
                for key, off, die, base in found:
                    packets.setdefault(
                        key, (alias.get(off), base, KIND[die.tag], die.size,
                              resolve(die.fields, local, rename)))
                for off, (name, die) in closure.items():
                    if die.tag == TAG_enum:
                        enums.setdefault(name, (die.size, list(die.fields or ())))
                    else:
                        types.setdefault(
                            name, (alias.get(off), "", KIND[die.tag], die.size,
                                   resolve(die.fields or (), local, rename)))

        pos = cu_end
        ncu += 1
        if progress and ncu % 200 == 0:
            print(f"\r  {ncu} CUs  {100.0 * pos / total:5.1f}%  "
                  f"{len(sizes)} names", end="", file=sys.stderr, flush=True)

    if progress:
        print(f"\r  {ncu} CUs  100.0%  {len(sizes)} names        ", file=sys.stderr)

    return (sizes, {n: s for n, s in seen.items() if len(s) > 1},
            layouts, packets, types, enums)


def strip_type(ref, local):
    """Follow typedef/cv/array wrappers down to the DIE that has a layout."""
    hops = 0
    while ref is not None and hops < 16:
        t = local.get(ref)
        if t is None:
            return None, None
        if t.tag in (TAG_typedef, TAG_const, TAG_volatile, TAG_array):
            ref, hops = t.type, hops + 1
            continue
        return ref, t
    return None, None


def walk_closure(found, local, alias):
    """Every aggregate and enum reachable from a packet field, in one CU.

    A packet table alone cannot be turned into a compilable header: roughly
    thirty packets have a field whose type is another struct, and a few of those
    nest further. This collects that closure so the generated header is
    self-contained.

    Returns (closure, rename):
      closure {die_offset: (name, die)}
      rename  {die_offset: name} for the aggregates GCC left anonymous
    """
    closure, rename, taken = {}, {}, set()
    # Packets are emitted from `found`; seeding them here stops the walk from
    # re-emitting one that happens to be nested inside another, and terminates
    # any cycle a self-referential type would otherwise create.
    for key, off, _die, _base in found:
        closure[off] = None
        taken.add(key)

    def mint(owner, field):
        """Name an anonymous aggregate after where it is used.

        GCC calls these `._157`, numbered from a counter that restarts in every
        translation unit, so the name is both meaningless and ambiguous across
        the binary. The use site is neither.
        """
        stem = f"{owner}_{field}_t" if field else f"{owner}_u"
        name, n = stem, 2
        while name in taken:
            name, n = f"{stem}{n}", n + 1
        taken.add(name)
        return name

    def visit(off, die, owner, field):
        if off in closure:
            return
        name = die.name or alias.get(off)
        if not name or name.startswith("._"):
            name = mint(owner, field)
            rename[off] = name
        else:
            taken.add(name)
        closure[off] = (name, die)
        for fname, _off, ref in (die.fields or ()):
            sub_off, sub = strip_type(ref, local)
            if sub is not None and sub.tag in AGGREGATE + (TAG_enum,):
                visit(sub_off, sub, name, fname)

    for key, _off, die, _base in found:
        for fname, _o, ref in (die.fields or ()):
            sub_off, sub = strip_type(ref, local)
            if sub is not None and sub.tag in AGGREGATE + (TAG_enum,):
                visit(sub_off, sub, key, fname)

    for _key, off, _die, _base in found:
        closure.pop(off, None)
    return closure, rename


def resolve(fields, local, rename=None):
    """Turn raw (name, offset, type_ref) rows into (name, offset, type, size).

    Done at the end of the CU that produced them, because `local` -- the only
    place the referenced type DIEs exist -- is discarded with the CU.
    """
    return [(name, off, type_name(ref, local, rename=rename),
             type_size(ref, local)) for name, off, ref in fields]


def verify(packets, label="packet"):
    """Check each extracted layout against sizeof. Returns 0 when all hold.

    A DWARF reader can be subtly wrong -- misread a form, drop a child, shift an
    offset -- and still produce plausible-looking numbers. This is the check
    that catches that: for every packet, the last field must end exactly at
    sizeof, or be a flexible array beginning exactly at sizeof. Holding across
    hundreds of independent structs is not something a broken parser does.

    Unions are exempt: their members all sit at offset 0 and DWARF gives them no
    location, so the invariant does not apply.

    Trailing padding is counted separately rather than failed. Not every struct
    a packet embeds is `#pragma pack(1)`: `VIEW_OTHER_DETAIL_INFO` ends 1 byte
    short of its sizeof because on i386 a `long long` member gives the struct
    4-byte alignment and 139 rounds up to 140. A generator that assumed pack(1)
    everywhere would emit 139 and shift every field after it.
    """
    ok = flex = pad = bad = union = 0
    padded, failures = [], []
    for name in sorted(packets):
        _alias, _base, kind, size, rows = packets[name]
        if kind == "union" or not rows:
            union += 1
            continue
        fname, off, _ty, fsz = rows[-1]
        if fsz is None:
            if off == size:
                flex += 1
                continue
        elif off is not None and off + fsz == size:
            ok += 1
            continue
        elif off is not None and 0 < size - (off + fsz) < 8:
            pad += 1
            padded.append((name, size, size - (off + fsz)))
            continue
        bad += 1
        failures.append((name, size, fname, off, fsz))

    print(f"\nverify: {len(packets)} {label} layouts"
          + (f"  ({union} unions / empty, not applicable)" if union else ""))
    print(f"  last field ends exactly at sizeof   {ok}")
    print(f"  flexible tail starting at sizeof    {flex}")
    print(f"  trailing alignment padding          {pad}")
    print(f"  INCONSISTENT                        {bad}")
    for name, size, n in padded[:20]:
        print(f"    pad: {name} sizeof={size}, {n} byte(s) after the last field")
    for name, size, fname, off, fsz in failures[:20]:
        print(f"    {name}: sizeof={size} last={fname} off={off} size={fsz}")
    return 1 if bad else 0


def record(sizes, seen, name, size):
    s = seen.get(name)
    if s is None:
        seen[name] = {size}
        sizes[name] = size
    else:
        s.add(size)


def load_tsv(path):
    out = {}
    with open(path, "r", encoding="utf-8") as fh:
        next(fh, None)
        for line in fh:
            parts = line.rstrip("\n").split("\t")
            if len(parts) >= 2:
                out[parts[0]] = int(parts[1])
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("binary", help="path to the shipped jx_linux_y")
    ap.add_argument("-o", "--out", help="write the full size table here")
    ap.add_argument("--compare", metavar="TSV",
                    help="compare against a struct_sizes.tsv from our build")
    ap.add_argument("--members", metavar="NAME", action="append", default=[],
                    help="dump the field layout of NAME (repeatable)")
    ap.add_argument("--packets", metavar="TSV",
                    help="enumerate every struct deriving from a protocol "
                         "header base and write their full layouts here")
    ap.add_argument("--types", metavar="TSV",
                    help="write the aggregates a packet field refers to -- the "
                         "closure a generated header needs to compile")
    ap.add_argument("--enums", metavar="TSV",
                    help="write the enums reachable from a packet field")
    ap.add_argument("--all-enums", action="store_true",
                    help="with --enums, write every named enum in the binary, "
                         "not only the ones a packet field refers to")
    ap.add_argument("--packet-base", action="append", default=None,
                    metavar="TYPE",
                    help="base type that marks a struct as a packet "
                         "(default: tagProtocolHeader, tagProtocolHeader2, "
                         "EXTEND_HEADER)")
    ap.add_argument("--verify", action="store_true",
                    help="check every extracted packet layout for internal "
                         "consistency (implies --packets on a temp table)")
    ap.add_argument("-q", "--quiet", action="store_true")
    args = ap.parse_args()

    bases = set(args.packet_base or
                ("tagProtocolHeader", "tagProtocolHeader2", "EXTEND_HEADER"))

    sections = read_sections(args.binary)
    if ".debug_info" not in sections:
        sys.exit(f"{args.binary} has no .debug_info -- it was stripped")
    if not args.quiet:
        print(f"reading DWARF from {args.binary} "
              f"({len(sections['.debug_info']) / 1e6:.1f} MB of .debug_info)",
              file=sys.stderr)

    want_packets = bool(args.packets or args.types or args.enums or args.verify)
    sizes, conflicts, layouts, packets, types, enums = walk(
        sections, args.members, not args.quiet,
        packet_bases=bases if want_packets else None,
        all_enums=args.all_enums)

    rc = 0
    if args.verify:
        rc |= verify(packets)
        rc |= verify(types, "referenced type")

    def write_layouts(path, table, label):
        with open(path, "w", encoding="utf-8", newline="\n") as fh:
            fh.write("struct\talias\tbase\tkind\tsize\toffset\tfield\ttype\t"
                     "fieldsize\n")
            for name in sorted(table):
                al, base, kind, size, rows = table[name]
                for fname, off, ty, fsz in rows:
                    fh.write(f"{name}\t{al or ''}\t{base}\t{kind}\t{size}\t"
                             f"{'' if off is None else off}\t"
                             f"{'' if fname is None else fname}\t{ty}\t"
                             f"{'' if fsz is None else fsz}\n")
        nf = sum(len(v[4]) for v in table.values())
        print(f"wrote {path}: {len(table)} {label}, {nf} fields")

    if args.packets:
        write_layouts(args.packets, packets, "packet structs")
    if args.types:
        write_layouts(args.types, types, "referenced types")
    if args.enums:
        with open(args.enums, "w", encoding="utf-8", newline="\n") as fh:
            fh.write("enum\tsize\tenumerator\tvalue\n")
            for name in sorted(enums):
                size, rows = enums[name]
                for ename, val, _ in rows:
                    fh.write(f"{name}\t{size}\t{ename}\t{val}\n")
        nv = sum(len(v[1]) for v in enums.values())
        print(f"wrote {args.enums}: {len(enums)} enums, {nv} enumerators")

    if args.out:
        with open(args.out, "w", encoding="utf-8", newline="\n") as fh:
            fh.write("struct\tsize\n")
            for n in sorted(sizes):
                fh.write(f"{n}\t{sizes[n]}\n")
        print(f"wrote {args.out}: {len(sizes)} names")

    for name in args.members:
        rows = layouts.get(name)
        total = sizes.get(name, "?")
        print(f"\n{name}  sizeof={total}")
        if not rows:
            print("  (no member layout in the binary)")
            continue
        print(f"  {'off':>5} {'size':>5}  {'type':<28} field")
        for m, off, ty, sz in rows:
            flex = "" if sz is not None else "   <- flexible / unsized"
            print(f"  {'?' if off is None else off:>5} "
                  f"{'-' if sz is None else sz:>5}  {ty:<28} {m}{flex}")

    # GCC names anonymous aggregates `._NNN` from a counter that restarts in
    # every translation unit, so the same synthetic name denotes different types
    # in different files. Those collisions are guaranteed by construction and
    # say nothing about the real types; only a collision on a source-level name
    # would mean the size table is ambiguous.
    real = {n: s for n, s in conflicts.items() if not n.startswith("._")}
    synthetic = len(conflicts) - len(real)
    if real:
        print(f"\n{len(real)} source-level names carry more than one size in "
              f"the binary -- the table is ambiguous for these:")
        for n in sorted(real)[:20]:
            print(f"  {n}: {sorted(real[n])}")
    elif not args.quiet:
        print(f"\nno source-level name is ambiguous "
              f"({synthetic} anonymous ._N collisions ignored)")

    if args.compare:
        ours = load_tsv(args.compare)
        match = mismatch = absent = 0
        bad = []
        for name, our_size in sorted(ours.items()):
            theirs = sizes.get(name)
            if theirs is None:
                absent += 1
            elif theirs == our_size:
                match += 1
            else:
                mismatch += 1
                bad.append((name, our_size, theirs))

        print(f"\ncompared {len(ours)} structs against the binary")
        print(f"  match         {match:4d}")
        print(f"  MISMATCH      {mismatch:4d}")
        print(f"  not in DWARF  {absent:4d}   (binary never references them)")
        if bad:
            print(f"\n  {'struct':<42} {'ours':>6} {'binary':>7}  delta")
            for name, o, t in bad:
                print(f"  {name:<42} {o:>6} {t:>7}  {t - o:+d}")
        rc |= 1 if mismatch else 0
    return rc


if __name__ == "__main__":
    sys.exit(main())
