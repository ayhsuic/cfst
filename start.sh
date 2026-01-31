#!/bin/bash

# 自动将 Zeabur 的端口变量注入 Nginx 配置
cat > /etc/nginx/http.d/default.conf <<EOF
server {
    listen ${PORT:-80}; # 如果变量为空则默认80
    root /var/www/html;
    location / {
        add_header Content-Type text/plain;
    }
}
EOF

# 启动 Nginx
nginx

# 初始占位文件
echo "Checking IPs..." > /var/www/html/index.txt

# 循环优选
while true; do
    ./cfst -f ip.txt -tl 150 -p 0 -o result.csv
    if [ -f "result.csv" ]; then
        # 存入 index.txt 供 GCP 访问
        sed -n '2,11p' result.csv | awk -F, '{print $1}' > /var/www/html/index.txt
    fi
    sleep 1800
done
