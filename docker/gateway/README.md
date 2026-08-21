# Gateway Docker Runner

Runs the 32-bit Linux gateway binaries under a `linux/386` container:

- `goddess_y` listens on `5001`.
- `bishop_y` listens on `5622`, `5623`, and `5632` according to `gateway/bishop.cfg`.
- Container `127.0.0.1:5002` is forwarded to the `paysys` service (`PAY_SYS_TARGET`, default `paysys:5002`), so the existing `AccSvrIP = 127.0.0.1` in `bishop.cfg` can stay unchanged.
- On Docker Desktop/macOS Apple Silicon, qemu-i386 rejects these old ELF files with `PT_LOAD with non-writable bss`. A temporary-copy patcher exists behind `PATCH_ELF_BSS=1`, but these binaries then fail their own integrity check. In practice, run this compose on real x86_64 Linux, not Apple Silicon emulation.

Before starting, stop any local probe using `5622` or `5623`.

The gateway is part of the consolidated stack; start it (Compose brings up its
`mysql57`/`paysys`/`s3relay_ref` dependencies first):

```bash
docker compose up -d --build gateway
```

Useful checks:

```bash
docker logs -f jx_gateway
docker exec -it jx_gateway ss -ltnp
```
