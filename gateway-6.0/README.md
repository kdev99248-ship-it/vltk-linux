# gateway-6.0

Thư mục gateway server 6.0 (goddess_y, bishop_y, s3relay/s3relay_y, libheaven.so,
librainbow.so + các file cfg). Đây là bind mount cho service `gateway` trong
`docker-compose.yml` (`./gateway-6.0:/home/jxser/gateway`).

Thư mục này ĐÃ được nạp sẵn từ bản `jxser/gateway` sạch. Nếu cần làm mới:

```bash
cp -r /đường/dẫn/jxser/gateway/. ./gateway-6.0/
```

Chỉ hỗ trợ server 6.0.
