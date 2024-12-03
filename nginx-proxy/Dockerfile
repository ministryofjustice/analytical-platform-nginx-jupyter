#checkov:skip=CKV_DOCKER_3: Migrate as is 

FROM openresty/openresty:alpine-fat
RUN mkdir /var/log/nginx
RUN apk add --no-cache \
    "openssl-dev=3.3.2-r1" \
    "git=2.45.2-r0" \
    "gcc=13.2.1_git20240309-r0"
RUN luarocks install lua-resty-openidc
COPY nginx.conf.template /config/nginx.conf.template
COPY --chmod=0755 scripts/start_proxy.sh /usr/bin/start_proxy.sh
COPY custom_404.html /var/www/html

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD ["/usr/local/bin/healthcheck.sh"]

CMD ["/usr/bin/start_proxy.sh"]
