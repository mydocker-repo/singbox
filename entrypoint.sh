#! /usr/bin/env bash
set -e
_UUID=$(cat /proc/sys/kernel/random/uuid)
[ ${#hostname} -eq 36 ] && UUID=${UUID:-$HOSTNAME}
UUID=${UUID:-$_UUID}
PORT=${PORT:-${SERVER_PORT:-35511}}
WS_PATH=${WS_PATH:-'/blackpath'}
#生成配置文件
cat <<EOF > /etc/sing-box/config.json
{
	"inbounds": [{
		"type": "vmess",
		"listen": "::",
		"listen_port": $PORT,
		"tcp_fast_open": false,
		"proxy_protocol": false,
		"users": [{
			"uuid": "$UUID",
			"alterId": 0
		}],
		"transport": {
			"type": "ws",
			"path": "$WS_PATH",
			"max_early_data": 2048,
			"early_data_header_name": "Sec-WebSocket-Protocol"
		},
		"multiplex": {
			"enabled": true,
			"padding": true,
			"brutal": {
				"enabled": true,
				"up_mbps": 1000,
				"down_mbps": 1000
			}
		}
	}]
}
EOF

