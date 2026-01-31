FROM alpine:latest

# 安装 Nginx 和 测速需要的工具
RUN apk add --no-cache bash wget curl tar nginx

# 设置工作目录
WORKDIR /app

# 下载 v2.3.4
RUN wget -N https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.3.4/cfst_linux_amd64.tar.gz && \
    tar -zxf cfst_linux_amd64.tar.gz && \
    chmod +x cfst

# 写入 IP 段
RUN echo "162.159.192.0/24" > ip.txt && \
    echo "162.159.193.0/24" >> ip.txt && \
    echo "162.159.239.0/24" >> ip.txt

# 准备 Nginx 运行目录
RUN mkdir -p /run/nginx /var/www/html

# 复制启动脚本
COPY start.sh /start.sh
RUN chmod +x /start.sh

# 启动
CMD ["/bin/sh", "-c", "/start.sh"]
