
FROM library/nginx:1.25
WORKDIR /root
ADD https://github.com/SagerNet/sing-box/releases/download/v1.12.12/sing-box-1.12.12-linux-amd64.tar.gz .
RUN tar -zxf sing-box-1.12.12-linux-amd64.tar.gz && cp sing-box-1.12.12-linux-amd64/sing-box  /usr/local/bin/ && rm *.tar.gz
COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json ./
CMD ["/usr/local/bin/sing-box" "run" "-c" "/root/config.json"]
