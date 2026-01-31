#!/bin/bash

# 后台测速逻辑不变
(
while true; do
    echo "开始优选测速..."
    ./cfst -f ip.txt -tl 150 -dn 10 -p 0 -o result.csv
    
    if [ -f "result.csv" ]; then
        sed -n '2p' result.csv | awk -F, '{print $1}' > index.txt
        echo "优选完成，当前最优 IP: $(cat index.txt)"
    fi
    sleep 1800
done
) &

# 换成 Python3 启动 Web 服务
# 它会自动监听 Zeabur 分配的 $PORT
echo "启动 Web 服务在端口 $PORT..."
python3 -m http.server $PORT
