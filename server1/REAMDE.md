# server1

Thư mục game server (jx_linux_y, vdk.so, maps/, settings/, script/ ...). Đây là
bind mount cho service `gateway` trong `docker-compose.yml`
(`./server1:/home/jxser/server1`).

Thư mục này ĐÃ được nạp sẵn từ bản `jxser/server1` sạch. Nếu cần làm mới:

```bash
cp -r /đường/dẫn/jxser/server1/. ./server1/
```

Game server dùng MySQL (database `server1`) — cùng engine với account services.
