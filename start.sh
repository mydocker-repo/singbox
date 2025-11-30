#! /usr/bin/sh
if [ -z "$UUID" ]; then
 UUID='6e7e4fc7-198e-4f17-8bbf-0dacfc8f8d4d'
fi
cat <<EOF > config.json
{
  "inbounds": [
    {
        "type":"vmess",
        "tag":"vmess-in",
        "listen":"::",
        "listen_port":35551,
        "tcp_fast_open":false,
        "proxy_protocol":false,
        "users":[
            {
                "uuid":"$UUID",
                "alterId":0
            }
        ],
        "transport":{
            "type":"ws",
            "path":"/vmess",
            "max_early_data":2048,
            "early_data_header_name":"Sec-WebSocket-Protocol"
        },
        "multiplex":{
            "enabled":false
        }
    },
    {
      "type":"vless",
      "tag":"vless-in",
      "listen":"::",
        "listen_port":35552,
        "tcp_fast_open":false,
        "proxy_protocol":false,
      "users":[
        {
          "uuid":"$UUID",
          "flow":""
        }
      ],
        "transport":{
            "type":"ws",
            "path":"/vless",
            "max_early_data":2048,
            "early_data_header_name":"Sec-WebSocket-Protocol"
        },
        "multiplex":{
            "enabled":false
        }
    }
    ,
    {
      "type":"trojan",
      "tag":"trojan-in",
      "listen":"::",
        "listen_port":35553,
        "tcp_fast_open":false,
        "proxy_protocol":false,
      "users":[
        {
          "password":"$UUID"
        }
      ],
        "transport":{
            "type":"ws",
            "path":"/trojan",
            "max_early_data":2048,
            "early_data_header_name":"Sec-WebSocket-Protocol"
        },
        "multiplex":{
            "enabled":false
        }
    }
  ]
}
EOF

DOMAIN=$ZEABUR_PORT_80_DOMAIN
VMESS=$(
cat <<EOF |base64
{
  "v": "2",
  "ps": "$DOMAIN",
  "add": "$DOMAIN",
  "port": "443",
  "id": "$UUID",
  "aid": "0",
  "scy": "none",
  "net": "ws",
  "type": "none",
  "host": "$DOMAIN",
  "path": "/vmess",
  "tls": "tls",
  "sni": "",
  "alpn": "",
  "fp": "chrome",
  "insecure": "1"
}
EOF
)
LINK=$(
cat <<EOF |base64
vmess://$VMESS

vless://$UUID@$DOMAIN:443?encryption=none&security=tls&fp=chrome&insecure=1&allowInsecure=1&type=ws&host=DOMAIN&path=%2Fvless#DOMAIN

trojan://$UUID@$DOMAIN:443?security=tls&fp=chrome&insecure=1&allowInsecure=1&type=ws&host=$DOMAIN&path=%2Ftrojan#$DOMAIN
EOF
)

echo $LINK >"/usr/share/nginx/html/$UUID"
echo $LINK

nginx && sing-box run 
