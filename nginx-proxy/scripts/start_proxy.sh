#!/bin/bash
envsubst '${REDIRECT_DOMAIN} ${AUTH0_TENANT_DOMAIN} ${AUTH0_CLIENT_ID} ${AUTH0_CLIENT_SECRET} ${LOGOUT_URL} ${APP_HOST} ${APP_PORT} ${USERNAME}' < /config/nginx.conf.template > /config/nginx.conf
/usr/local/openresty/nginx/sbin/nginx -g 'daemon off;' -c /config/nginx.conf
