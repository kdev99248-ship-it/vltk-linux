#!/usr/bin/env bash
set -euo pipefail

MYSQL_TARGET="${MYSQL_TARGET:-mysql57:3306}"
CAPTURE_DIR="${CAPTURE_DIR:-/captures}"
CAPTURE_DAY="$(date -u +%Y%m%d)"
PAY_SYS_CONFIG_DIR="${PAY_SYS_CONFIG_DIR:-/work/config}"
MYSQL_WAIT_TIMEOUT="${MYSQL_WAIT_TIMEOUT:-180}"
mkdir -p "${CAPTURE_DIR}/logs"

# Preserve decrypted packet logs with UTC timestamps for correlation.
exec > >(while IFS= read -r line; do \
    printf '%s %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "${line}"; \
  done | tee -a "${CAPTURE_DIR}/logs/paysys_${CAPTURE_DAY}.log") 2>&1

wait_for_tcp() {
  local target="$1" timeout="$2" label="$3"
  local host="${target%:*}" port="${target##*:}" elapsed=0
  echo "[paysys] waiting for ${label} at ${host}:${port} (timeout ${timeout}s)"
  until timeout 1 bash -c "</dev/tcp/${host}/${port}" 2>/dev/null; do
    if (( elapsed >= timeout )); then
      echo "[paysys] ERROR: ${label} did not become ready within ${timeout}s"
      return 1
    fi
    sleep 1
    ((elapsed += 1))
  done
  echo "[paysys] ${label} TCP endpoint is ready"
}

wait_for_tcp "${MYSQL_TARGET}" "${MYSQL_WAIT_TIMEOUT}" MySQL

echo "[paysys] starting sword3paysys_cpp (MySQL backend) with ${PAY_SYS_CONFIG_DIR}"
exec /usr/local/bin/sword3paysys-cpp "${PAY_SYS_CONFIG_DIR}"
