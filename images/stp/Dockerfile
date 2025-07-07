FROM alpine:3
LABEL name="erudin_stp" maintainer="andares@foxmail.com"

# 安装必要组件
RUN apk add --no-cache \
    iptables \
    iproute2 \
    dnsmasq \
    redsocks \
    curl

# 复制配置文件和启动脚本
COPY redsocks.conf /etc/redsocks.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]