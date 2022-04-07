FROM openresty/openresty:alpine-fat
RUN mkdir /var/log/nginx
RUN apk add --no-cache openssl-dev git gcc
RUN luarocks install lua-resty-openidc
COPY nginx.conf.template /config/nginx.conf.template
COPY scripts/start_proxy.sh /usr/bin/start_proxy.sh
RUN chmod +x /usr/bin/start_proxy.sh

CMD /usr/bin/start_proxy.sh
