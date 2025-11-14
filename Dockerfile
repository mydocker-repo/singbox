FROM gzxhwq/sing-box:1.12.12-server 

# 创建配置文件目录
RUN mkdir -p /etc/sing-box

# 复制本地配置文件到镜像中
COPY config.json  /etc/sing-box/config.json 

