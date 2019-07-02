#!/bin/bash
# Download and extract of Nginx source code
		echo "Downloading NGINX..."
		sleep 3
		cd /usr/local/src/nginx/ || exit 1
		NGINX_VER=1.17.0
		wget -qO- http://nginx.org/download/nginx-${NGINX_VER}.tar.gz | tar zxf -
		NGINX_VER=1.17.0
		cd nginx-${NGINX_VER}

		# As the default nginx.conf does not work, we download a clean and working conf from my GitHub.
		# We do it only if it does not already exist, so that it is not overriten if Nginx is being updated
		if [[ ! -e /etc/nginx/nginx.conf ]]; then
			mkdir -p /etc/nginx
			cd /etc/nginx || exit 1
			wget https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/conf/nginx.conf
		fi
		echo "Configuring NGINX"
		sleep 3
		cd /usr/local/src/nginx/nginx-${NGINX_VER} || exit 1


./configure --build=OptimEngine-V3.0 --user=www-data --group=www-data --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --with-openssl-opt=no-nextprotoneg --with-openssl-opt=no-weak-ssl-ciphers --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_mp4_module --with-http_auth_request_module --with-http_slice_module --with-http_stub_status_module --with-http_realip_module --with-pcre-jit --with-debug --with-cc-opt='-g -O2 -fPIC -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIC -pie -Wl,-z,relro -Wl,-z,now' --with-pcre-opt='-g -Ofast -fPIC -m64 -march=native -fstack-protector-strong -D_FORTIFY_SOURCE=2' --with-zlib-opt='-g -Ofast -fPIC -m64 -march=native -fstack-protector-strong -D_FORTIFY_SOURCE=2' --with-http_degradation_module --with-http_addition_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_sub_module --with-http_secure_link_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-select_module --with-poll_module --add-module=/usr/local/src/nginx/modules/ngx_devel_kit --add-module=/usr/local/src/nginx/modules/incubator-pagespeed-ngx-${NPS_VER}-stable --add-module=/usr/local/src/nginx/modules/ngx_brotli --add-module=/usr/local/src/nginx/modules/headers-more-nginx-module-${HEADERMOD_VER} --add-module=/usr/local/src/nginx/modules/ngx_http_geoip2_module-${GEOIP2_VER} --with-openssl=/usr/local/src/nginx/modules/openssl-${OPENSSL_VER} --add-module=/usr/local/src/nginx/modules/ngx_cache_purge --add-module=/usr/local/src/nginx/modules/fancyindex --with-http_dav_module --add-module=/usr/local/src/nginx/modules/nginx-dav-ext-module --add-module=/usr/local/src/nginx/modules/nginx-modsec-connect --add-module=/usr/local/src/nginx/modules/srcache-nginx-module --add-module=/usr/local/src/nginx/modules/redis2-nginx-module --add-module=/usr/local/src/nginx/modules/set-misc-nginx-module --add-module=/usr/local/src/nginx/modules/ngx_http_redis-${HTTP_REDIS_VER} --add-module=/usr/local/src/nginx/modules/memc-nginx-module --add-module=/usr/local/src/nginx/modules/echo-nginx-module --with-pcre=/usr/local/src/nginx/modules/pcre-${PCRE_NGINX_VER} --with-zlib=/usr/local/src/nginx/modules/zlib-${ZLIB_NGINX_VER}

make -j "$(nproc)"
make install
# remove debugging symbols
strip -s /usr/sbin/nginx
sleep 3

echo "Nginx Configured Successfully"
