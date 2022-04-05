#!/bin/bash

check_vars()
{
    var_names=("$@")
    for var_name in "${var_names[@]}"; do
        [ -z "${!var_name}" ] && echo "$var_name is unset." && var_unset=true
    done
    [ -n "$var_unset" ] && exit 1
    return 0
}

# set -u checks if the values are set, but docker-compose is setting the variables to be blank strings if never set, 
# so this checks if they are blank OR unset.
check_vars REDIRECT_DOMAIN AUTH0_TENANT_DOMAIN AUTH0_CLIENT_ID AUTH0_CLIENT_SECRET LOGOUT_URL APP_HOST APP_PORT USERNAME

envsubst '${REDIRECT_DOMAIN} ${AUTH0_TENANT_DOMAIN} ${AUTH0_CLIENT_ID} ${AUTH0_CLIENT_SECRET} ${LOGOUT_URL} ${APP_HOST} ${APP_PORT} ${USERNAME}' < /config/nginx.conf.template > /config/nginx.conf
/usr/local/openresty/nginx/sbin/nginx -g 'daemon off;' -c /config/nginx.conf
