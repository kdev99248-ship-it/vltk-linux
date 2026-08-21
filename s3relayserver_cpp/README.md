# s3relayserver_cpp

C++ S3Relay replacement using the `account_tong` Relay schema (MySQL) and the
Heaven encrypted protocol.

## Runtime

- Requires `libmysqlclient` (dev headers) at build time.
- Requires MySQL database `account_tong` and the `ServerList` table.
- Implements strict server verification, account/session state, route lookup,
  forwarding, heartbeat and logout handling.
- Uses the native Windows Relay wire opcodes without a file-backed runtime.
- Requires the Heaven cipher table at `config/reference/heaven_table.bin`.
- `relaxed_verify=1` in `Relay_Setup.ini` relaxes peer IP / identity / password
  checks for offline development.

The service intentionally fails fast when MySQL is unavailable. It listens on
port `5003` and exposes a protocol-level healthcheck.

Build through the repository Compose configuration:

```bash
docker compose build s3relay_ref
```
