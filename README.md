#railway 专用
> start.sh
```bash
# railway环境专用
if [ -z "$DOMAIN" ]; then
 DOMAIN=$RAILWAY_PUBLIC_DOMAIN
fi
if [ -z "$UUID" ]; then
 UUID='6e7e4fc7-198e-4f17-8bbf-0dacfc8f8d4d'
fi
REGION=$(echo $RAILWAY_REPLICA_REGION |cut -d'-' -f1,2)
NAME=$(echo $DOMAIN |cut -d'.' -f1)
TITLE="${NAME}-${REGION}"
```
