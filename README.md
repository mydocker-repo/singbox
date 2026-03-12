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
### 使用Cloudflare Workers反代理域名使用cdn加速
```
export default {
    async fetch(request, env) {
        let url = new URL(request.url);
        if (url.pathname.startsWith('/')) {
            var arrStr = [
                'change.your.domain', // 此处单引号里填写你的节点伪装域名
            ];
            url.protocol = 'https:'
            url.hostname = getRandomArray(arrStr)
            let new_request = new Request(url, request);
            return fetch(new_request);
        }
        return env.ASSETS.fetch(request);
    },
};
function getRandomArray(array) {
  const randomIndex = Math.floor(Math.random() * array.length);
  return array[randomIndex];
}
```
