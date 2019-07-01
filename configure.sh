#!/bin/bash
# Define versions
OPTIM_NGINX_VER=18.0
NGINX_MAINLINE_VER=1.17.0
NGINX_STABLE_VER=1.16.0
LIBRESSL_VER=2.9.0
OPENSSL_VER=1.1.1a
NPS_VER=1.13.35.2
HEADERMOD_VER=0.33
LIBMAXMINDDB_VER=1.3.2
GEOIP2_VER=3.2
HTTP_REDIS_VER=0.3.9
PCRE_NGINX_VER=8.42
ZLIB_NGINX_VER=1.2.11 


./configure --user=www-data --group=www-data --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --with-openssl-opt=no-nextprotoneg --with-openssl-opt=no-weak-ssl-ciphers --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_mp4_module --with-http_auth_request_module --with-http_slice_module --with-http_stub_status_module --with-http_realip_module --with-pcre-jit --with-debug --with-http_degradation_module --with-http_addition_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_sub_module --with-http_secure_link_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-select_module --with-poll_module --add-module=/usr/local/src/nginx/modules/ngx_devel_kit --add-module=/usr/local/src/nginx/modules/incubator-pagespeed-ngx-${NPS_VER}-stable --add-module=/usr/local/src/nginx/modules/ngx_brotli --add-module=/usr/local/src/nginx/modules/headers-more-nginx-module-${HEADERMOD_VER} --add-module=/usr/local/src/nginx/modules/ngx_http_geoip2_module-${GEOIP2_VER} --with-openssl=/usr/local/src/nginx/modules/openssl-${OPENSSL_VER} --add-module=/usr/local/src/nginx/modules/ngx_cache_purge --add-module=/usr/local/src/nginx/modules/fancyindex --with-http_dav_module --add-module=/usr/local/src/nginx/modules/nginx-dav-ext-module --add-module=/usr/local/src/nginx/modules/nginx-modsec-connect --add-module=/usr/local/src/nginx/modules/srcache-nginx-module --add-module=/usr/local/src/nginx/modules/redis2-nginx-module --add-module=/usr/local/src/nginx/modules/set-misc-nginx-module --add-module=/usr/local/src/nginx/modules/ngx_http_redis-${HTTP_REDIS_VER} --add-module=/usr/local/src/nginx/modules/memc-nginx-module --add-module=/usr/local/src/nginx/modules/echo-nginx-module --with-pcre=/usr/local/src/nginx/modules/pcre-${PCRE_NGINX_VER} --with-zlib=/usr/local/src/nginx/modules/zlib-${ZLIB_NGINX_VER}

make -j "$(nproc)"
make install
# remove debugging symbols
strip -s /usr/sbin/nginx
sleep 3

echo "Nginx Configured Successfully"
