FROM alpine:latest

# 增加 python3
RUN apk add --no-cache bash wget curl tar python3

WORKDIR /app

# 下载并解压 CFST
RUN wget -N https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.3.4/cfst_linux_amd64.tar.gz && \
    tar -zxf cfst_linux_amd64.tar.gz && \
    chmod +x cfst

COPY start.sh /start.sh
RUN chmod +x /start.sh

RUN echo "162.159.192.0/24" > ip.txt && \
    echo "162.159.193.0/24" >> ip.txt && \
    echo "162.159.239.0/24" >> ip.txt

CMD ["/bin/sh", "-c", "/start.sh"]
