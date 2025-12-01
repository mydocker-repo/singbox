FROM gzxhwq/sing-box:1.12.12-server AS singbox

FROM library/nginx:1.25
WORKDIR /root
COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=singbox /usr/local/bin/sing-box /usr/local/bin/sing-box
RUN mkdir -p /etc/sing-box
COPY config.json /etc/sing-box/config.json
COPY start.sh /docker-entrypoint.d/
RUN chmod 755 /docker-entrypoint.d/start.sh
