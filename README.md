# VLTK Pay Runtime

This repository contains the reconstructed runtime for two proprietary VLTK
services:

- `sword3paysys_cpp`: the C++ PaySys replacement for the Linux service.
- `s3relayserver_cpp`: the C++ S3Relay replacement used by the default runtime.

The implementations preserve the observed Heaven protocol, encrypted framing,
response layouts, connection state, and database postconditions. Authentication
is enforced by the configured backend and protocol flow; this is not a
password-bypass implementation.

Both account services now use **MySQL** — the same engine as the Linux game
server — so the whole stack runs on one database engine (`mysql57`). The former
MSSQL dependency has been removed.

## Quick start

```bash
docker compose up -d --build
```

That single command brings up the entire offline stack:

1. `mysql57` initialises two databases on first boot — `account_tong`
   (accounts/relay) from `dbbackup/account_tong.sql` and `server1` (game) from
   `dbbackup/server1.sql`.
2. `paysys` (C++ PaySys, :5002) and `s3relay_ref` (C++ S3Relay, :5003) connect
   to MySQL and wait for it to become healthy.
3. `gateway` runs the original Linux binaries (goddess/bishop/s3relay_y/
   jx_linux_y) once the account services are healthy.

Default login for the migrated accounts (`yuh1`..`yuh100`, `test`,
`guolijian000`) is the password **`1`**.

> The Heaven cipher table required by both C++ services is already present at
> `config/reference/heaven_table.bin` (extracted and cross-verified against the
> shipped `bishop_y`/`goddess_y`/`s3relay_y`/`jx_linux_y` binaries).
> The `gateway-6.0/` and `server1/` folders hold the game binaries and are the
> bind mounts the `gateway` service uses.

## Architecture

```text
Client ──► Gateway/Bishop ──► C++ PaySys  :5002 ─┐
                       └────► C++ S3Relay :5003 ─┤
                                                 ├──► MySQL :3306
GameServer/Goddess/Bishop/s3relay_y ─────────────┘   (account_tong + server1)
```

The Compose topology is a single file (`docker-compose.yml`) with four services:
`mysql57`, `paysys`, `s3relay_ref`, and `gateway`. There is no MSSQL service.

## Implemented protocol surface

- `0x21` (`kOpcodeAccountLogin`): account credential exchange and account/IP operations.
- `0x22`: game-login forwarding or local consumption.
- `0x23`: logout and session cleanup.
- `0x24`: Gateway/Relay verification.
- `0x26` (`kOpcodeGatewayInfo`): native gateway-info and route/address queries.
- `0x70` / `0x82`: heartbeat request and response.

The numeric opcode values and wire layouts remain unchanged; descriptive names
are source-level constants only. Native runtime persistence uses MySQL for the
PaySys and Relay services. CSV files under `captures/` are historical evidence,
not runtime data sources.

## Safety and reliability

- Strict peer, server, credential, port, and frame validation.
- Atomic MySQL account/session mutations with rollback on failure.
- Duplicate-route ownership protection and controlled reconnect handoff.
- Business-level healthchecks and bounded malformed-frame fuzzing.

## Verifying a run

After `docker compose up -d --build`, check that all four services report
`healthy`:

```bash
docker compose ps
```

Then confirm a client can log in with one of the migrated accounts (password
`1`). See [GUIDE.md](GUIDE.md) for healthcheck details and troubleshooting.

## Scope and limitations

The C++ services cover the captured PaySys and S3Relay branches, including
verification, login, heartbeat, logout, routing, database failure handling,
malformed frames, duplicate sessions, and concurrency. This is not a claim of
perfect equivalence for binary branches that were never captured.

Gateway gameplay executables (Goddess, Bishop, and GameServer) remain part of
the existing runtime; this repository replaces PaySys and S3Relay only.

## Related documentation

- [GUIDE.md](GUIDE.md): build, configuration, startup, healthchecks, testing, and troubleshooting.
- [docs/OPERATIONS.md](docs/OPERATIONS.md): operations, rollback, and fixtures.
