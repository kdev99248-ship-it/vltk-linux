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
| `CClientConnection` | not started — §2 |
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

1. `CClientConnection` — the class from §2, plus `KSOServer::CreateClient`,
   `CloseClientConnections`, and `SendDataToServer` over `m_aConnections`.
   Five instances, none of them subclassed yet: base slot 4 returns 1, base
   slot 6 reconnects on a timer.
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
