FROM gzxhwq/sing-box:1.12.12-server 
# 复制本地配置文件到镜像中
COPY config.json  /etc/sing-box/config.json 

