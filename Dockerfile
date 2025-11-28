FROM gzxhwq/sing-box:1.12.12-server  AS singbox

FROM library/nginx:1.25
COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=singbox /usr/bin/sing-box /usr/local/bin/sing-box
RUN mkdir /etc/sing-box
COPY config.json  /etc/sing-box/
# 安装 supervisord（Debian 系用 apt）
RUN apt-get update && \
    apt-get install -y supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/log/supervisord

# 复制 supervisord 配置文件
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 暴露常用端口（根据你实际 sing-box 配置修改）
EXPOSE 80 443 8443 10000-10100/udp



# 使用 supervisord 启动 nginx 和 sing-box
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
