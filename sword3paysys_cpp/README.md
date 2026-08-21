# sword3paysys_cpp

C++ PaySys replacement using the `account_tong` account schema (MySQL) and the
Heaven encrypted protocol.

## Runtime

- Requires `libmysqlclient` (dev headers) at build time.
- Requires MySQL database `account_tong` at runtime (same engine as the game DB).
- Reads account credentials, online state, billing time and logout state from
  `Account_Info` and `Account_Habitus`.
- Password enforcement is controlled by `enforce_password` and supports the
  legacy client credential representation.
- Requires the Heaven cipher table at `config/reference/heaven_table.bin`.

The service intentionally fails fast when MySQL is unavailable. There is no
file-backed account runtime.

Build through the repository Compose configuration:

```bash
docker compose build paysys
```

Configuration is read from the mounted `config/` directory. The service listens
on port `5002` and exposes a protocol-level healthcheck.
