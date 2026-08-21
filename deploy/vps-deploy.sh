#!/usr/bin/env bash
#
# vps-deploy.sh — deploy the JX1/VLTK offline stack on a public Linux VPS.
#
# It does three things the LAN dev setup does not:
#   1. Rewrites the address advertised to clients (LAN IP -> your VPS PUBLIC_IP)
#      in every game .cfg/.ini, while keeping internal peers on 127.0.0.1.
#   2. Brings the stack up (backend ports are already loopback-bound in
#      docker-compose.yml; only the game ports are public).
#   3. Optionally installs a firewall allowlist for the public game ports.
#
# Usage:
#   deploy/vps-deploy.sh up               # patch IPs + build + start + status
#   deploy/vps-deploy.sh patch-ip         # only rewrite the advertised IP
#   deploy/vps-deploy.sh restore-ip       # revert IPs from the .jxbak backups
#   deploy/vps-deploy.sh firewall         # apply firewall (root; see flags)
#   deploy/vps-deploy.sh status           # docker compose ps + port map
#   deploy/vps-deploy.sh down             # stop the stack
#
# Flags:
#   up:        --no-build
#   firewall:  --harden-host   (also enable ufw; allows SSH_PORT first)
#
# Config is read from .env (see .env.example). PUBLIC_IP may also be passed
# as an environment variable.
set -euo pipefail

# --- locate the repo root (this script lives in <root>/deploy) ---------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
ENV_FILE="${ROOT}/.env"
GW="${ROOT}/gateway-6.0"
SV="${ROOT}/server1"

# Ports that must be reachable by remote clients.
CLIENT_PORTS="5622 5623 5632 6666"

c_red()  { printf '\033[31m%s\033[0m\n' "$*"; }
c_grn()  { printf '\033[32m%s\033[0m\n' "$*"; }
c_ylw()  { printf '\033[33m%s\033[0m\n' "$*"; }
die()    { c_red "ERROR: $*"; exit 1; }
have()   { command -v "$1" >/dev/null 2>&1; }

# --- read a single key from .env (KEY=value, optional quotes) -----------------
env_get() {
  local k="$1" line
  [ -f "$ENV_FILE" ] || return 0
  line="$(grep -E "^[[:space:]]*${k}[[:space:]]*=" "$ENV_FILE" | tail -n1 || true)"
  line="${line#*=}"
  printf '%s' "$line" | sed -E 's/^[[:space:]]*//; s/[[:space:]]*$//; s/^"(.*)"$/\1/; s/^'\''(.*)'\''$/\1/'
}

PUBLIC_IP="${PUBLIC_IP:-$(env_get PUBLIC_IP)}"
SSH_PORT="${SSH_PORT:-$(env_get SSH_PORT)}"; SSH_PORT="${SSH_PORT:-22}"
ALLOW_CLIENT_IPS="${ALLOW_CLIENT_IPS:-$(env_get ALLOW_CLIENT_IPS)}"

valid_ipv4() {
  local ip="$1" o
  [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || return 1
  IFS='.' read -ra o <<< "$ip"
  for n in "${o[@]}"; do (( n >= 0 && n <= 255 )) || return 1; done
  return 0
}

compose() {
  if docker compose version >/dev/null 2>&1; then
    ( cd "$ROOT" && docker compose "$@" )
  elif have docker-compose; then
    ( cd "$ROOT" && docker-compose "$@" )
  else
    die "docker compose (v2) not found."
  fi
}

# --- IP patching --------------------------------------------------------------
# Back up a file once (keeps the pristine copy in <file>.jxbak).
backup_once() { [ -f "$1.jxbak" ] || cp -p "$1" "$1.jxbak"; }

# set_key <file> <key-regex> <value>  — replace `key = ...` in place.
# Applies to every matching line (all matches should share one meaning).
set_key() {
  local f="$1" k="$2" v="$3"
  [ -f "$f" ] || { c_ylw "  skip (missing): ${f#$ROOT/}"; return 0; }
  sed -i -E "s|^([[:space:]]*${k}[[:space:]]*=[[:space:]]*).*|\1${v}|" "$f"
}

patch_ip() {
  valid_ipv4 "$PUBLIC_IP" || die "PUBLIC_IP is not a valid IPv4 (got: '${PUBLIC_IP:-<empty>}'). Set it in .env."
  [ -d "$GW" ] && [ -d "$SV" ] || die "gateway-6.0/ or server1/ not found. Populate the bind mounts first."

  c_grn "Rewriting advertised address -> ${PUBLIC_IP} (internal peers stay 127.0.0.1)"

  local advertised=(
    "$GW/bishop.cfg"
    "$GW/goddess.cfg"
    "$GW/s3relay/relay_config.ini"
    "$SV/servercfg.ini"
    "$SV/servercf0.ini"
    "$SV/settings/serverlist.ini"
  )
  for f in "${advertised[@]}"; do [ -f "$f" ] && backup_once "$f"; done

  # FixIp advertised to clients (both Internet/Intranet -> public, so a remote
  # client always receives a reachable address regardless of classification).
  for f in "$GW/bishop.cfg" "$GW/goddess.cfg" "$GW/s3relay/relay_config.ini" \
           "$SV/servercfg.ini" "$SV/servercf0.ini"; do
    set_key "$f" "InternetIp" "$PUBLIC_IP"
    set_key "$f" "IntranetIp" "$PUBLIC_IP"
  done

  # In-game server list the client connects to (0_Address, 1_Address, ...).
  set_key "$SV/settings/serverlist.ini" "[0-9]+_Address" "$PUBLIC_IP"

  # Internal peer addresses stay on loopback (relay <-> role server, same
  # container). Every bare `address =` in relay_config.ini is an internal hop.
  set_key "$GW/s3relay/relay_config.ini" "address" "127.0.0.1"

  c_grn "Done. Backups saved as *.jxbak next to each file."
}

restore_ip() {
  c_grn "Restoring IPs from *.jxbak backups"
  local n=0
  while IFS= read -r bak; do
    cp -p "$bak" "${bak%.jxbak}"; n=$((n+1))
    echo "  restored ${bak%.jxbak}"
  done < <(find "$GW" "$SV" -name '*.jxbak' 2>/dev/null)
  [ "$n" -gt 0 ] && c_grn "Restored $n file(s)." || c_ylw "No .jxbak backups found."
}

# --- firewall -----------------------------------------------------------------
need_root() { [ "$(id -u)" -eq 0 ] || die "firewall needs root. Re-run with sudo."; }

firewall() {
  local harden=0
  for a in "$@"; do case "$a" in --harden-host) harden=1;; esac; done
  need_root

  if [ -n "${ALLOW_CLIENT_IPS:-}" ]; then
    have iptables || die "iptables not found."
    c_grn "Restricting game ports (${CLIENT_PORTS// /, }) to: ${ALLOW_CLIENT_IPS}"
    # A dedicated chain we can flush idempotently, jumped from DOCKER-USER so it
    # filters Docker-published ports (plain ufw/INPUT rules do NOT).
    iptables -N JX_CLIENT 2>/dev/null || true
    iptables -F JX_CLIENT
    iptables -C DOCKER-USER -j JX_CLIENT 2>/dev/null || iptables -I DOCKER-USER -j JX_CLIENT
    local ips; IFS=',' read -ra ips <<< "$ALLOW_CLIENT_IPS"
    for p in $CLIENT_PORTS; do
      for ip in "${ips[@]}"; do
        ip="$(printf '%s' "$ip" | tr -d '[:space:]')"; [ -n "$ip" ] || continue
        iptables -A JX_CLIENT -p tcp --dport "$p" -s "$ip" -j RETURN
      done
      iptables -A JX_CLIENT -p tcp --dport "$p" -j DROP
    done
    c_ylw "Note: DOCKER-USER is reset when the Docker daemon restarts; re-run this after a reboot (or install iptables-persistent)."
  else
    c_ylw "ALLOW_CLIENT_IPS is empty -> game ports are open to EVERYONE (public play)."
  fi

  if [ "$harden" = 1 ]; then
    have ufw || die "ufw not found (install it or drop --harden-host)."
    c_grn "Hardening host with ufw (SSH on ${SSH_PORT} allowed first)"
    ufw allow "${SSH_PORT}/tcp"
    for p in $CLIENT_PORTS; do ufw allow "${p}/tcp"; done
    ufw --force enable
    c_ylw "Backend ports (3306/5002/5003/5001) are loopback-bound in compose, so ufw need not cover them."
  fi
}

# --- misc ---------------------------------------------------------------------
preflight() {
  have docker || die "docker not found."
  compose version >/dev/null 2>&1 || die "docker compose v2 not available."
  local arch; arch="$(uname -m)"
  [ "$arch" = "x86_64" ] || c_ylw "WARNING: arch is '$arch', not x86_64. The 32-bit game binaries may fail under emulation."
}

show_ports() {
  cat <<EOF

Port map
  Public (clients)   5622  bishop login (ClientOpenPort)
                     5623  bishop denial
                     5632  bishop game-server open
                     6666  jx_linux_y game data
  Loopback only      3306  MySQL   5002 PaySys   5003 Relay   5001 RoleServer
EOF
}

cmd_up() {
  local build="--build"
  for a in "$@"; do case "$a" in --no-build) build="";; esac; done
  preflight
  patch_ip
  c_grn "Starting stack..."
  # shellcheck disable=SC2086
  compose up -d $build
  cmd_status
  cat <<EOF

$(c_grn "Stack is up.")
Next:
  - Point your VLTK client at ${PUBLIC_IP}:5622
  - Lock down the game ports:   sudo deploy/vps-deploy.sh firewall
  - Verify which ports the client really uses: captures/pcap/*.pcap
Reminder: this build is offline-dev (accept_any_login, default password '1',
weak MySQL root). Keep backend ports loopback-only and restrict client IPs.
EOF
}

cmd_status() { compose ps || true; show_ports; }
cmd_down()   { compose down; }

main() {
  local sub="${1:-up}"; shift || true
  case "$sub" in
    up)         cmd_up "$@" ;;
    patch-ip)   patch_ip ;;
    restore-ip) restore_ip ;;
    firewall)   firewall "$@" ;;
    status)     cmd_status ;;
    down)       cmd_down ;;
    -h|--help|help)
      grep -E '^#( |$)' "$0" | sed -E 's/^# ?//' | head -n 32 ;;
    *) die "unknown command: $sub (try: up patch-ip restore-ip firewall status down)";;
  esac
}
main "$@"
