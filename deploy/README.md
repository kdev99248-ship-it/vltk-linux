# Deploy lên VPS Linux (chơi từ xa)

Công cụ `deploy/vps-deploy.sh` giúp đưa stack offline lên VPS public: tự đổi IP
quảng bá cho client sang IP VPS, giữ cổng backend đóng, và mở/siết đúng cổng
game. Chạy **trên VPS** (Linux x86_64).

## Yêu cầu VPS
- CPU **x86_64** (không dùng ARM — binary game là ELF 32-bit x86).
- RAM ≥ 4–6 GB. Docker + Docker Compose v2.
- Đã copy nguyên thư mục project lên VPS (kèm `gateway-6.0/` và `server1/` đã có binary).

## Các bước
```bash
# 1. Khai báo IP public của VPS
cp .env.example .env
nano .env                      # điền PUBLIC_IP=<ip_vps> (và SSH_PORT nếu khác 22)

# 2. Cấp quyền chạy (nếu cần)
chmod +x deploy/vps-deploy.sh

# 3. Vá IP + build + chạy
deploy/vps-deploy.sh up

# 4. Siết firewall (cần root)
sudo deploy/vps-deploy.sh firewall
```

Xong. Trỏ **client** về `PUBLIC_IP:5622` để đăng nhập (tài khoản `yuh1..yuh100`
/ `test` / `guolijian000`, mật khẩu `1`).

## Lệnh
| Lệnh | Việc |
|---|---|
| `vps-deploy.sh up [--no-build]` | Vá IP → build → chạy → in trạng thái |
| `vps-deploy.sh patch-ip` | Chỉ ghi IP public vào các file cfg/ini |
| `vps-deploy.sh restore-ip` | Khôi phục IP gốc từ bản sao `*.jxbak` |
| `vps-deploy.sh firewall [--harden-host]` | Mở/siết cổng (xem dưới) |
| `vps-deploy.sh status` | `docker compose ps` + bảng cổng |
| `vps-deploy.sh down` | Dừng stack |

## Cổng
| Cổng | Dịch vụ | Ra internet? |
|---|---|---|
| 5622 | bishop — client đăng nhập | **Có** (client) |
| 5623 | bishop — denial | **Có** (client) |
| 5632 | bishop — mở game server | **Có** (client) |
| 6666 | jx_linux_y — dữ liệu game | **Có** (client) |
| 3306 | MySQL (root) | Không — chỉ loopback |
| 5002 / 5003 / 5001 | PaySys / Relay / RoleServer | Không — chỉ loopback |

Các cổng backend đã được `docker-compose.yml` bind vào `127.0.0.1`, nên **không**
ra internet dù có publish. Chỉ 4 cổng game là công khai.

## Firewall — giới hạn ai được vào
- Để **mở cho tất cả** (public): để trống `ALLOW_CLIENT_IPS` trong `.env`.
- Để **chỉ cho vài IP bạn bè**: điền `ALLOW_CLIENT_IPS=1.2.3.4,5.6.7.8` rồi
  `sudo deploy/vps-deploy.sh firewall`. Tool cài luật vào chuỗi `DOCKER-USER`
  (ufw thường **không** chặn được cổng do Docker publish, nên phải dùng cách này).
- `--harden-host` sẽ bật thêm `ufw` cho phần còn lại của VPS (luôn cho phép
  `SSH_PORT` trước để không tự khóa mình).

> Luật `DOCKER-USER` bị Docker reset khi daemon khởi động lại. Sau khi reboot,
> chạy lại `sudo deploy/vps-deploy.sh firewall` (hoặc cài `iptables-persistent`).

## Cảnh báo bảo mật
Đây là bản **offline-dev, mở toang**: `accept_any_login=1`, tài khoản mật khẩu
`1`, MySQL root là mật khẩu mặc định yếu. Khi đưa ra internet, tối thiểu hãy:
- Giữ backend loopback (mặc định đã vậy) — **đừng** publish 3306/5002/5003 ra ngoài.
- Dùng `ALLOW_CLIENT_IPS` để chỉ cho người quen vào, hoặc bọc bằng VPN/WireGuard.
- Cân nhắc tắt `accept_any_login` trong `config/Acc_Setup.ini`.

## Kiểm tra / gỡ rối
- Xác nhận client thực sự đụng cổng nào: mở `captures/pcap/*.pcap` (project tự
  bắt gói). Cổng nào client dùng thì mở đúng cổng đó.
- Login lỗi ở khâu relay: đặt `relaxed_verify=1` trong `config/Relay_Setup.ini`.
- Muốn quay lại cấu hình LAN: `deploy/vps-deploy.sh restore-ip`.
- Nếu bash báo lỗi `\r`: file bị CRLF, chạy `sed -i 's/\r$//' deploy/vps-deploy.sh`.

Chi tiết vận hành khác xem [`../GUIDE.md`](../GUIDE.md) và
[`../docs/OPERATIONS.md`](../docs/OPERATIONS.md).
