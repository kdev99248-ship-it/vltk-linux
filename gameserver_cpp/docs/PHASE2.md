# Phase 2 — The five outbound links, and the bring-up handshake

Phase 1 ends with a server that accepts a client and reads its login. It cannot
answer one. `KServerCore::AttachPlayer` is a tail-call to
`KPlayerSet::AttachPlayer` @`0x80DD9A0`, and that function does not create
anything — it walks the list of players **that already exist** and looks for a
matching GUID:

```c
if (this->m_UseIdx.m_nSize <= 0) return 0;           // nobody loaded -> 0
...
if (*((_DWORD*)pWho + 33026) == -1                   // slot not yet claimed
 && !KPlayer::IsOfflineLive(pWho)
 && memcmp(&CONST_GUID_ZERO, pGuid, 0x10u)           // reject the null GUID
 && !memcmp((char*)Player + 165956*nPrev + 132068, pGuid, 0x10u))
    break;                                            // <- the only success
```

So a login can only succeed against a player the server was **already told
about**, by another server, before the client ever connected. That is the whole
reason Phase 2 exists, and it is why the phases split where they do: everything
downstream of the handshake — sync, the world, every one of the 574 packets —
is behind a link that has to be dialled first.

`sizeof(KPlayer)` is 165956; the GUID lives at +132068 and the network id at
+132104 (`33026 * 4`), sentinel `-1` for "not attached".

## Status

| Workstream | State |
|---|---|
| Which enum is which link | **done, verified** — three sources agree, §1 |
| `CClientConnection` | **done, runs** — all five links, §2 and §5 |
| Gateway (`emSERVER_BISHOP`) link and bring-up | not started — §3 |
| Relay (`emSERVER_HOST`) map load | not started — §3 |
| Database (`emSERVER_GODDESS`) link | not started |
| Chat / Tong links | not started |
| `KPlayerSet` and the player load | not started |

## 1. `KE_SERVERTYPE` does not mean what it says

The single most dangerous fact in this phase, and the one worth stating before
any code gets written:

| Enum | Value | ini section | Inbound processor |
|---|---|---|---|
| `emSERVER_GODDESS` | 0 | **`[Database]`** | `KGoddessProcess` |
| `emSERVER_BISHOP` | 1 | **`[Gateway]`** | `KBishopProcess` |
| `emSERVER_HOST` | 2 | `[Transfer]` | `KHostProcess` |
| `emSERVER_TONG` | 3 | `[Tong]` | `KTongProcess` |
| `emSERVER_CHAT` | 4 | `[Chat]` | `KChatProcess` |

Goddess is the **database** and bishop is the **gateway**. The names read
backwards against the ini, and against the rest of the stack, where "bishop" is
a separate process entirely. Three independent places in the binary agree, so
this is the shipped meaning and not a misreading:

* `KSOServer::SendDataToServer` @`0x804B120` routes `emSERVER_GODDESS` to
  `m_connDatabase` and `emSERVER_BISHOP` to `m_connGateway`.
* `KGoddessProcess::Process` @`0x81EC7E0` calls `DatabaseLargePackProcess` and
  prints `"Protocol:(%d) -- database error"`.
* `KBishopProcess::ProcessMessage` @`0x81ED9E0` calls
  `GatewayLargePackProcess` / `GatewaySmallPackProcess`.

The Phase 1 tree had this inverted in `KSOServer::Initialize`'s link table. It
was harmless while nothing read `m_aConnections` but the startup printf, and it
would have been a silent misrouting the moment `SendDataToServer` was wired.
Fixed: the array stays indexed by `KE_SERVERTYPE` and the *load* applies the
naming quirk once, so `SendDataToServer` is a plain `m_aConnections[nType]`.

## 2. `CClientConnection` — one class, five instances

All five links are the same class. It is small, and it is fully recovered:

```c
// CClientConnection::Open @0x804D080
if (!m_pClient) {
    if (!KSOServer::CreateClient(m_pServer, m_sConnection.nBufSize, &m_pClient)
     || !m_pClient) {
        puts("Initialization failed! Don't find a correct rainbow.dll");
        return 0;
    }
    printf("[%s]IP:%s, Port:%u\n", m_szConnection,
           m_sConnection.szIp, m_sConnection.nPort);
    m_pClient->RegisterEventHandler(this, CClientConnection::EventHandler);
}
if (m_pServer->GetIntranetIp())                    // IGameServer slot 7
    m_pClient->BindIp(m_pServer->GetIntranetIp()); // IClient slot 6
if (m_pClient->ConnectTo(inet_addr(m_sConnection.szIp),
                         (WORD)m_sConnection.nPort)) {
    printf("Connect [%s] successful!\n", m_szConnection);
    snprintf(szKey, 0x104u, "Logs/conn_%s", m_szConnection);
    KSG_LogFile::InitWithDate(&m_cLogFile, szKey, "log", 0);
    return 1;
}
printf("Connect to [%s] is failed!\n", m_szConnection);
return 0;
```

```c
// CClientConnection::ProcessMessages @0x804CE80
if (m_bResult) {
    this->vslot6();                                    // per-tick hook
    while (m_pClient && m_bResult) {
        size_t leng = 0;
        void* p = m_pClient->GetPackFromServer(leng);   // IClient slot 5
        if (!p || !leng) break;
        if (this->vslot4(p, leng))                      // per-message filter
            pCore->ProcessServerMessage(m_nType, p, leng);
    }
}
```

Two virtuals carry the per-link behaviour: **slot 4** is a filter run before
the message reaches the core (return 0 to swallow it), **slot 6** is a per-tick
hook — reconnect and heartbeat live there. The rest is shared.

`ProcessServerMessage` @`0x804DE40` is then just a jump table over
`KE_SERVERTYPE` into the five `*Process::ProcessMessage` entry points listed in
§1.

## 3. The bring-up handshake

`KBishopProcess::GatewaySmallPackProcess` @`0x81ED700` is the startup
conversation, and it decides the order the links have to come up in:

1. **Gateway → server, protocol 49.** Carries a `tm` at +9..+44 and two DWORDs
   at +1 and +5. The server calls `settimeofday()` from it — it takes its clock
   from the gateway, `tz_minuteswest = 8`, `tz_dsttime = 2` — then
   `InitServerTime(pData+1, &tm)` and `SetGateWayClientID(pData+5)`.
   It immediately replies **to the relay**, not the gateway: a 6-byte
   `RELAY_QUERY_MAP { ProtocolFamily=1, ProtocolID=49, dwServerID }` sent to
   `emSERVER_HOST`. If that send fails:

   ```
   ERROR: Requesting Map From Relay Failed! Confirm that Relay is Normally Running!
   ```

   followed by `m_pServer->Release()` — the process shuts itself down.

2. **Gateway → server, protocol 50** = "identify yourself". The server answers
   with a 13-byte `tagGameSvrInfo` (`cProtocol = 51`) to `emSERVER_BISHOP`,
   filled from `IGameServer` slots 6/7/8/9 — internet ip, intranet ip, port,
   and the ip as a string. One special case: if the string form is
   `"127.0.0.1"` the intranet field is forced to `16777343` (`0x7F000001`).
   `wCapability` is `m_nMaxPlayerCount`.

3. **Relay → server**, the map payload, ending in **protocol 0xD2** →
   `m_bReady = 1` and `"update map ok"` in the log.

Only after that does the gateway start handing clients over. So the dependency
order is **gateway first, relay with it** (step 1 fails hard without the
relay), then database, then chat and tong.

Note also that the shipped `CreateClientConnections` returns 0 if *any* of the
five fails, and `Initialize` fails with it. The real server does not start
without all five. Phase 1 deliberately deviates; that deviation ends here.

## 4. Order of work

1. ~~`CClientConnection` — the class from §2, plus `KSOServer::CreateClient`,
   `CloseClientConnections`, and `SendDataToServer` over the five links.~~
   **Done** — see §5. All five subclasses shipped, including the ping
   connection, because `CTongConnection` cannot be built without it.
2. `KBishopProcess` — protocols 49, 50/51 and 0xD2 from §3. This is the
   smallest change that gets a real gateway to accept the port as a gameserver.
3. `KHostProcess` — enough of the relay link to answer `RELAY_QUERY_MAP` and
   reach `m_bReady`.
4. `KGoddessProcess` + `KPlayerSet` — the player load, which is what finally
   makes `AttachPlayer` able to return non-zero and turns the Phase 1 handshake
   into a login.
5. Chat and tong, which are not on the login path at all.

Step 2 is also where the oracle diff that Phase 1 could not run becomes
possible: with the gateway link up, the ported server and `jx_linux_y` can be
pointed at the same gateway in turn and their traffic compared byte for byte.

## 5. Step 1, verified

Run in the build container with the five peers on 46001-46005 and both
addresses pinned to 127.0.0.1 through `[FixIp]`.

| What | Result |
|---|---|
| Dial order | `Goddess, Chat, Tong, Tran, Bishop` — the iteration order of `m_pClientConnections`, gateway last, **not** `KE_SERVERTYPE` order |
| Per-link log files | `Logs/conn_{Bishop,Chat,Goddess,Tong,Tran}_<date>.log`, created by `KSG_LogFile::InitWithDate` at connect time |
| Main loop with all five up | one `FPS=0` warning, then silence — `m_nGameFPS` is only assigned when `m_dwElapseTick` is non-zero, so loop 1 keeps the initial 0 and every loop after it reports 18 |
| Tong heartbeat | 10 bytes, `0f 2b` = family 15 / id 43, sequence 0,1,2,3,4, timestamps 3001/6002/9003/12004/15005 ms |
| Losing a **prime** link (Tong) | `connection[Tong] lost` → `GameServer exit...` → all five closed in iteration order |
| Losing the **non-prime** link (Chat) | `connection[Chat] lost`, server keeps running |

Two things about the rig are worth writing down, because both cost time.

**A socket that only accepts is not a peer.** `librainbow.so` runs its own key
handshake (`KClientManager::InitializeKey`) before it flushes anything the
application queued, so against an accept-only stub `SendPackToServer` returns 1
on every call and not one byte reaches the wire. The heartbeat above is
invisible until the other end is a real `libheaven.so` listener — which is what
`probe_heaven_stub.cpp` is for, and using heaven as the peer also decodes the
traffic, so the table's `0f 2b` is plaintext read through the same KSG coder the
gameserver encoded it with. That the two agree is a second, free check on the
cipher.

**`stdbuf` cannot unbuffer this binary.** It works by `LD_PRELOAD`, and the
preload object is 64-bit while `jx_gameserver` is i386, so a run killed by
`timeout` loses its entire startup banner to libc's block buffer and looks like
a server that printed nothing. Run it under a pty instead — libc line-buffers
when stdout is a terminal.
