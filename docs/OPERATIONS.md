# Runtime and data operations

## Default runtime

The whole offline stack (`mysql57`, `paysys`, `s3relay_ref`, `gateway`) starts
from a single Compose file:

```sh
docker compose up -d --build
```

Both C++ services (`paysys` = `sword3paysys_cpp`, `s3relay_ref` =
`s3relayserver_cpp`) talk to MySQL and expose Docker healthchecks. The default
runtime does not start Wine, MDAC, Xvfb, MSSQL, or any proprietary Windows
binary.

## MySQL data persistence and clean re-seed

MySQL data is persisted on the host at `./dockerdata/mysql_server1/data`. The
seed files in `dbbackup/` (`account_tong.sql`, `server1.sql`) are applied
**only** when that directory is empty, i.e. on the first boot.

To force a clean re-initialisation from the SQL seeds (this **destroys** all
current MySQL data — accounts, characters, everything):

```sh
docker compose down
rm -rf ./dockerdata/mysql_server1/data
docker compose up -d --build
```

On the next start MySQL recreates `account_tong` and `server1` from the seed
files. Never do this against data you want to keep — take a dump first:

```sh
docker exec jx1_mysql mysqldump -uroot -p1234560123 \
  --databases account_tong server1 > backup.sql
```

## Rollback

- **Runtime/DB state** — restore from a `mysqldump` backup, or wipe and re-seed
  as above.
- **Relay target** — to point the Gateway at a different Relay endpoint without
  editing source, set `S3RELAY_TARGET` (default `10.211.55.4:5003`) before
  `docker compose up`.
