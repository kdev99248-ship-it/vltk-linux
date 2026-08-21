# VLTK Runtime Guide

Build, configuration, startup, healthchecks, and troubleshooting for the
offline JX1 / VLTK stack. Everything runs on one database engine (**MySQL**) and
starts with a single command.

## Requirements

- Docker Engine (or Docker Desktop) with Compose v2.
- Permission to run Docker commands (Linux/WSL2 recommended).
- For native (non-Docker) builds of the C++ services: CMake, a C++17 compiler,
  and `libmysqlclient` dev headers.

## Build and start

The whole stack lives in a single `docker-compose.yml`:

```bash
docker compose up -d --build
```

This builds and starts four services:

| Service       | Container        | Role                                              | Ports                          |
|---------------|------------------|---------------------------------------------------|--------------------------------|
| `mysql57`     | `jx1_mysql`      | `account_tong` (accounts/relay) + `server1` (game)| `3306`                         |
| `paysys`      | `jx_paysys_cpp`  | C++ PaySys (`sword3paysys_cpp`)                   | `5002`                         |
| `s3relay_ref` | `jx_s3relay_cpp` | C++ S3Relay (`s3relayserver_cpp`)                | `5003`                         |
| `gateway`     | `jx_gateway`     | goddess / bishop / s3relay_y / jx_linux_y        | `5001`, `5622`, `5623`, `5632`, `6666` |

Startup order is enforced by healthchecks: `paysys` and `s3relay_ref` wait for
MySQL to become healthy, and `gateway` waits for all three to be healthy before
launching the original Linux binaries.

Inspect service state (the `STATUS` column shows `healthy`/`unhealthy`):

```bash
docker compose ps
```

## First-boot database initialisation

On the **first** start with an empty data directory
(`./dockerdata/mysql_server1/data`), MySQL runs the seed files in filename
order:

1. `dbbackup/account_tong.sql` → database `account_tong` (accounts + relay:
   `Account_Info`, `Account_Habitus`, `ServerList`).
2. `dbbackup/server1.sql` → database `server1` (game).

These run **only** when the data directory is empty. To force a clean re-seed,
see [`docs/OPERATIONS.md`](docs/OPERATIONS.md).

## Login

The migrated accounts (`yuh1`..`yuh100`, `test`, `guolijian000`) all use the
password **`1`**. Password enforcement is controlled by `enforce_password` in
`config/Acc_Setup.ini`.

## Heaven cipher table

Both C++ services need the Heaven encrypted-protocol table at
`config/reference/heaven_table.bin`. It is **already present** in the repository
(extracted and cross-verified against the shipped `bishop_y`, `goddess_y`,
`s3relay_y`, and `jx_linux_y` binaries), so no extra step is required.

## Configuration

Runtime settings live under `config/` and are mounted read-only into the
services:

- `config/db.ini` — MySQL connection (server, user, password, database,
  charset). This is the single source of DB connection settings for both C++
  services.
- `config/Acc_Setup.ini` — PaySys: listen port `5002`, `accept_any_login`,
  `enforce_password`.
- `config/Relay_Setup.ini` — S3Relay: listen port `5003`, `backend=mysql`,
  `relaxed_verify` (set `1` to relax peer IP / identity / password checks for
  offline development).

## Remote play on a VPS

The default configuration is for LAN/offline use. To run on a public Linux VPS
and let people connect over the internet, use the deploy tool, which rewrites
the client-advertised address to your public IP, keeps backend ports on
loopback, and installs a firewall allowlist for the game ports:

```bash
cp .env.example .env      # set PUBLIC_IP=<your VPS IP>
deploy/vps-deploy.sh up
sudo deploy/vps-deploy.sh firewall
```

Full instructions: [`deploy/README.md`](deploy/README.md).

## Healthchecks

Health is reported by Docker; read it with `docker compose ps`:

- `mysql57` — `mysqladmin ping`.
- `paysys` / `s3relay_ref` — a TCP probe of the service port (`5002` / `5003`)
  that only passes once the service is accepting connections.

## Troubleshooting

View recent logs by container:

```bash
docker logs --tail=200 jx1_mysql
docker logs --tail=200 jx_paysys_cpp
docker logs --tail=200 jx_s3relay_cpp
docker logs --tail=200 jx_gateway
```

- **A C++ service exits immediately** — check that MySQL is healthy
  (`docker compose ps`) and that `config/reference/heaven_table.bin` is present.
  Both services fail fast when MySQL is unavailable.
- **Login fails** — confirm the account exists in `account_tong.Account_Info`
  and that `enforce_password` in `config/Acc_Setup.ini` matches the stored
  credential (migrated accounts use password `1`).
- **Client reports server full / under maintenance** — verify Relay health and
  Gateway→Relay routing, then inspect `jx_s3relay_cpp` logs for peer-identity or
  verification failures. As a fallback for offline development, set
  `relaxed_verify=1` in `config/Relay_Setup.ini`.
- **Gateway can't reach Relay** — the Gateway targets `10.211.55.4:5003` on the
  `gateway_lan` network so native Relay peer-IP verification sees the expected
  identity. Override with `S3RELAY_TARGET` only for special topologies.

For data reset, rollback, and reference tooling, see
[`docs/OPERATIONS.md`](docs/OPERATIONS.md).
