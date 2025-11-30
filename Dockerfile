FROM library/nginx:1.25
COPY nginx.conf /etc/nginx/nginx.conf
RUN apk --no-cache sing-box

WORKDIR /root
COPY config.json ./
CMD ["sing-box" "run" "-c" "config.json"]
