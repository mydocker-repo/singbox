FROM gzxhwq/sing-box:1.12.12-server  AS builder

FROM library/nginx:1.25
COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /usr/local/bin/sing-box /usr/local/bin/sing-box
COPY --from=builder /etc/ssl/certs/* /etc/ssl/certs/
RUN mkdir /etc/sing-box
COPY config.json  /etc/sing-box/config.json 

ENTRYPOINT ["/usr/local/bin/sing-box run -D /etc/sing-box"]
