FROM gzxhwq/sing-box:1.12.12-server AS singbox
FROM library/nginx:1.25
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=singbox /usr/local/bin/sing-box /usr/local/bin/sing-box
RUN chmod +x /usr/local/bin/sing-box && \
    echo 'export PATH="/usr/local/bin:$PATH"' >> /root/.bashrc
WORKDIR /root
COPY config.json ./
CMD ["sing-box" "run" "-c" "config.json"]
