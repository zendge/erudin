#!/bin/sh

# 设置默认值
PROXY_HOST=${PROXY_HOST:-proxy.example.com}
PROXY_PORT=${PROXY_PORT:-1080}
PROXY_USER=${PROXY_USER:-user}
PROXY_PASS=${PROXY_PASS:-pass}

# 更新配置文件中的变量
sed -i "s|\$PROXY_HOST|$PROXY_HOST|g" /etc/redsocks.conf
sed -i "s|\$PROXY_PORT|$PROXY_PORT|g" /etc/redsocks.conf
sed -i "s|\$PROXY_USER|$PROXY_USER|g" /etc/redsocks.conf
sed -i "s|\$PROXY_PASS|$PROXY_PASS|g" /etc/redsocks.conf

# 启动 redsocks
redsocks -c /etc/redsocks.conf

# 设置 iptables 规则
iptables -t nat -N PROXY
iptables -t nat -A PROXY -d 0.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 10.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 127.0.0.0/8 -j RETURN
iptables -t nat -A PROXY -d 169.254.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 172.16.0.0/12 -j RETURN
iptables -t nat -A PROXY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A PROXY -d 224.0.0.0/4 -j RETURN
iptables -t nat -A PROXY -d 240.0.0.0/4 -j RETURN

# 重定向所有 TCP 流量到 redsocks
iptables -t nat -A PROXY -p tcp -j REDIRECT --to-ports 12345

# 应用规则到 OUTPUT 链
iptables -t nat -A OUTPUT -p tcp -j PROXY

# 启动 DNS 服务
dnsmasq -k --log-facility=- --cache-size=1000

# 保持容器运行
tail -f /dev/null