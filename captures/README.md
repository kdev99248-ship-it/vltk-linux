# Protocol capture evidence

All timestamps are UTC so packet captures and logs can be correlated directly.

- `pcap/gateway_*.pcap`: raw traffic on TCP ports 5001, 5002, 5003, 5622, 5623, 5632, and the internal RootRelay port 7777; files rotate hourly.
- `pcap/s3relay_*.pcap`: raw S3Relay traffic on TCP port 5003; files rotate hourly.
- `logs/paysys_decrypted_YYYYMMDD.log`: reference PaySys output, including decrypted packet bodies.
- `logs/s3relay_decrypted_YYYYMMDD.log`: reference S3Relay output, including decrypted packet bodies.
- `logs/gateway_YYYYMMDD.log`: Gateway entrypoint plus Goddess/Bishop stdout/stderr.
- `../gateway-6.0/Logs/`: native Goddess/Bishop application logs.
- `timeline.csv`: manually recorded client actions.

Record each test action in `timeline.csv` immediately before performing it, so
it correlates with the UTC-stamped captures — for example:

```bash
printf '%s,%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "submit login: test account" >> timeline.csv
```

Do not put passwords in event descriptions.
