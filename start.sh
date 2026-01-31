#!/bin/bash

# 后台循环测速逻辑
(
while true; do
    echo "开始优选测速..."
    # -f ip.txt 使用专用段, -p 0 禁用 TCP 测速(WARP通常只用UDP)
    ./cfst -f ip.txt -tl 150 -dn 10 -p 0 -o result.csv
    
    # 提取最快的第 1 名 IP 存入 index.txt
    if [ -f "result.csv" ]; then
        sed -n '2p' result.csv | awk -F, '{print $1}' > index.txt
        echo "优选完成，当前最优 IP: $(cat index.txt)"
    fi
    
    # 每 30 分钟更新一次
    sleep 1800
done
) &

# 启动 Web 服务 (Busybox httpd) 监听 Zeabur 分配的 $PORT
# 这个命令会让当前目录下的 index.txt 可以通过网页访问
busybox httpd -f -p $PORT

