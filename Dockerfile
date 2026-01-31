FROM alpine:latest

# 安装必要依赖
RUN apk add --no-cache bash wget curl tar

# 1. 设置工作目录
WORKDIR /app

# 2. 下载并解压 CFST (v2.3.4)
RUN wget -N https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.3.4/cfst_linux_amd64.tar.gz && \
    tar -zxf cfst_linux_amd64.tar.gz && \
    chmod +x cfst

# 3. 复制启动脚本 (文件 2) 进镜像
COPY start.sh /start.sh
RUN chmod +x /start.sh

# 4. 准备 WARP 专用 IP 段文件
RUN echo "162.159.192.0/24" > ip.txt && \
    echo "162.159.193.0/24" >> ip.txt && \
    echo "162.159.239.0/24" >> ip.txt

# 5. 启动
CMD ["/bin/sh", "-c", "/start.sh"]
