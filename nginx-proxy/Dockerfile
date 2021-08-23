FROM openresty/openresty:alpine-fat
RUN mkdir /var/log/nginx
RUN apk add --no-cache openssl-dev git gcc
RUN luarocks install lua-resty-openidc
COPY nginx.conf.template /config/nginx.conf.template

CMD envsubst '${REDIRECT_DOMAIN} ${AUTH0_TENANT_DOMAIN} ${AUTH0_CLIENT_ID} ${AUTH0_CLIENT_SECRET} ${LOGOUT_URL} ${APP_HOST} ${APP_PORT} ${USERNAME}' < /config/nginx.conf.template > /config/nginx.conf && /usr/local/openresty/nginx/sbin/nginx -g 'daemon off;' -c /config/nginx.conf || cat /config/nginx.conf
