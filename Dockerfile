FROM gzxhwq/sing-box:1.12.12-server AS singbox
WORKDIR /root
RUN which sing-box > sb.txt
FROM library/nginx:1.25
WORKDIR /root
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=singbox /root/sb.txt ./
COPY --from=singbox /usr/local/bin/sing-box /usr/local/bin/sing-box
RUN chmod +x /usr/local/bin/sing-box && \
    echo 'export PATH="/usr/local/bin:$PATH"' >> /root/.bashrc
COPY config.json ./

