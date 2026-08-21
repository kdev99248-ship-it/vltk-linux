#!/usr/bin/env bash
set -euo pipefail

CAPTURE_DIR="${CAPTURE_DIR:-/captures}"
CAPTURE_DAY="$(date -u +%Y%m%d)"
MYSQL_TARGET="${MYSQL_TARGET:-mysql57:3306}"
MYSQL_WAIT_TIMEOUT="${MYSQL_WAIT_TIMEOUT:-180}"
S3RELAY_CONFIG_DIR="${S3RELAY_CONFIG_DIR:-/work/config}"
CAPTURE_PCAP="${CAPTURE_PCAP:-0}"
mkdir -p "${CAPTURE_DIR}/pcap" "${CAPTURE_DIR}/logs"

exec > >(while IFS= read -r line; do \
    printf '%s %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "${line}"; \
  done | tee -a "${CAPTURE_DIR}/logs/s3relay_${CAPTURE_DAY}.log") 2>&1

wait_for_tcp() {
  local target="$1" timeout="$2" label="$3"
  local host="${target%:*}" port="${target##*:}" elapsed=0
  echo "[s3relay] waiting for ${label} at ${host}:${port} (timeout ${timeout}s)"
  until timeout 1 bash -c "</dev/tcp/${host}/${port}" 2>/dev/null; do
    if (( elapsed >= timeout )); then
      echo "[s3relay] ERROR: ${label} did not become ready within ${timeout}s"
      return 1
    fi
    sleep 1
    ((elapsed += 1))
  done
  echo "[s3relay] ${label} TCP endpoint is ready"
}

wait_for_tcp "${MYSQL_TARGET}" "${MYSQL_WAIT_TIMEOUT}" MySQL

if [[ "${CAPTURE_PCAP}" == "1" ]]; then
  echo "[s3relay] capturing raw traffic on TCP port 5003"
  tcpdump -i any -U -n -s 0 -G 3600 \
    -w "${CAPTURE_DIR}/pcap/s3relay_%Y%m%dT%H%M%SZ.pcap" tcp port 5003 &
fi

echo "[s3relay] starting s3relayserver_cpp (MySQL backend) with ${S3RELAY_CONFIG_DIR}"
exec /usr/local/bin/s3relayserver-cpp "${S3RELAY_CONFIG_DIR}"
