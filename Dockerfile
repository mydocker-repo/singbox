FROM gzxhwq/sing-box:1.12.12-server AS singbox
FROM library/nginx:1.25
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=singbox /ko/sing-box /usr/local/bin/sing-box

WORKDIR /root
COPY config.json ./
CMD ["sing-box" "run" "-c" "config.json"]
