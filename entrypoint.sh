#!/usr/bin/env bash
DECODED_URL=$(echo "aHR0cHM6Ly9naXRodWIuY29tL1hUTFMvWHJheS1jb3JlL3JlbGVhc2VzL2xhdGVzdC9kb3dubG9hZC9YcmF5LWxpbnV4LTY0LnppcA==" | base64 -d)
wget -O /tmp/xray.zip "$DECODED_URL"
unzip /tmp/xray.zip
rm /tmp/xray.zip
chmod +x xray
# 定义 UUID 及伪装路径、哪吒面板参数，请自行修改. (注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
UUID='de04add9-5c68-8bab-950c-08cd5320df18'
VMESS_WSPATH='/vmess'
VLESS_WSPATH='/vless'
TROJAN_WSPATH='/trojan'
SS_WSPATH='/shadowsocks'
NEZHA_SERVER=''
NEZHA_PORT=''
NEZHA_KEY=''
sed -i "s#UUID#$UUID#g;s#VMESS_WSPATH#${VMESS_WSPATH}#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g;s#TROJAN_WSPATH#${TROJAN_WSPATH}#g;s#SS_WSPATH#${SS_WSPATH}#g" config.json
sed -i "s#VMESS_WSPATH#${VMESS_WSPATH}#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g;s#TROJAN_WSPATH#${TROJAN_WSPATH}#g;s#SS_WSPATH#${SS_WSPATH}#g" /etc/nginx/nginx.conf
sed -i "s#RELEASE_RANDOMNESS#${RELEASE_RANDOMNESS}#g" /etc/supervisor/conf.d/supervisord.conf

rm -rf /usr/share/nginx/*
#wget https://gitlab.com/Misaka-blog/xray-paas/-/raw/main/mikutap.zip -O /usr/share/nginx/mikutap.zip

unzip -o ./LensPause-main.zip -d /usr/share/nginx/html
rm -rf ./LensPause-main.zip


RELEASE_RANDOMNESS=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv xray ${RELEASE_RANDOMNESS}
rm -rf xray

cat config.json | base64 > config
rm -f config.json

nginx
base64 -d config > config.json
./${RELEASE_RANDOMNESS} -config=config.json > /dev/null 2>&1

