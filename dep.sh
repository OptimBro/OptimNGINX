#!/bin/bash
		echo "Installing Dependencies..."
		apt-get -o Acquire::ForceIPv4=true install -y build-essential ca-certificates wget curl libpcre3 libpcre3-dev autoconf unzip automake libtool tar git libssl-dev zlib1g-dev uuid-dev lsb-release libxml2-dev libxslt1-dev
    apt-get -o Acquire::ForceIPv4=true install -y apt-utils autoconf automake build-essential git libcurl4-openssl-dev libgeoip-dev liblmdb-dev libpcre++-dev libtool libxml2-dev libyajl-dev pkgconf wget zlib1g-dev git
		apt-get -o Acquire::ForceIPv4=true install -y libtool autoconf build-essential libpcre3-dev zlib1g-dev libssl-dev libxml2-dev libgeoip-dev liblmdb-dev libyajl-dev libcurl4-openssl-dev libpcre++-dev pkgconf libxslt1-dev libgd-dev
		echo "Dependencies Installed"
		sleep 3

		echo "Configuring PageSpeed"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			wget https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VER}-stable.zip
			unzip v${NPS_VER}-stable.zip
			cd incubator-pagespeed-ngx-${NPS_VER}-stable || exit 1
			psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_VER}.tar.gz
			[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
			wget "${psol_url}"
			tar -xzvf "$(basename "${psol_url}")"

		echo "Configuring Brotli Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			git clone https://github.com/eustas/ngx_brotli
			cd ngx_brotli || exit 1
			git checkout v0.1.2
			git submodule update --init

		echo "Configuring Headers More Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			wget https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERMOD_VER}.tar.gz
			tar xaf v${HEADERMOD_VER}.tar.gz

		echo "Configuring GeoIP Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			# install libmaxminddb
			wget https://github.com/maxmind/libmaxminddb/releases/download/${LIBMAXMINDDB_VER}/libmaxminddb-${LIBMAXMINDDB_VER}.tar.gz
			tar xaf libmaxminddb-${LIBMAXMINDDB_VER}.tar.gz
			cd libmaxminddb-${LIBMAXMINDDB_VER}/
			./configure
			make
			make install
			ldconfig

			cd ../
			wget https://github.com/leev/ngx_http_geoip2_module/archive/${GEOIP2_VER}.tar.gz
			tar xaf ${GEOIP2_VER}.tar.gz

			mkdir geoip-db
			cd geoip-db || exit 1
			wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz
			wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
			tar -xf GeoLite2-City.tar.gz
			tar -xf GeoLite2-Country.tar.gz
			mkdir /opt/geoip
			cd GeoLite2-City_*/
			mv GeoLite2-City.mmdb /opt/geoip/
			cd ../
			cd GeoLite2-Country_*/
			mv GeoLite2-Country.mmdb /opt/geoip/

		echo "Configuring Cache Purge Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			git clone https://github.com/torden/ngx_cache_purge


		echo "Configuring OpenSSL"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			wget https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz
			tar xaf openssl-${OPENSSL_VER}.tar.gz
			cd openssl-${OPENSSL_VER}

			./config

		echo "Configuring ModSecurity"
		sleep 3
		if [[ ! -d /usr/local/src/nginx/modules/ModSecurity ]]; then
      
			cd /usr/local/src/nginx/modules || exit 1
			git clone --depth 1 -b v3/master --single-branch https://github.com/SpiderLabs/ModSecurity
			cd ModSecurity || exit 1
			git submodule init
      git submodule update
			./build.sh
      ./configure
       make
       make install
       
    fi

		echo "Configuring SRCache Module "
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			git clone https://github.com/openresty/srcache-nginx-module

		echo "Configuring Redis2 Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			git clone https://github.com/openresty/redis2-nginx-module

		echo "Configuring Set_Misc Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			git clone https://github.com/openresty/set-misc-nginx-module
	

		echo "Configuring HTTP Redis Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			wget https://people.freebsd.org/~osa/ngx_http_redis-${HTTP_REDIS_VER}.tar.gz
			tar xaf ngx_http_redis-${HTTP_REDIS_VER}.tar.gz
			cd ngx_http_redis-${HTTP_REDIS_VER}

		echo "Configuring PCRE_NGINX Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_NGINX_VER}.tar.gz
			tar xaf pcre-${PCRE_NGINX_VER}.tar.gz
			cd pcre-${PCRE_NGINX_VER}

		echo "Configuring ZLIB_NGINX Module"
		sleep 3
			cd /usr/local/src/nginx/modules || exit 1
			wget http://zlib.net/zlib-${ZLIB_NGINX_VER}.tar.gz
			tar xaf zlib-${ZLIB_NGINX_VER}.tar.gz
			cd zlib-${ZLIB_NGINX_VER}

echo "Installing Github Dependencies..."

git clone --quiet https://github.com/simplresty/ngx_devel_kit.git /usr/local/src/nginx/modules/ngx_devel_kit
git clone --quiet https://github.com/aperezdc/ngx-fancyindex.git /usr/local/src/nginx/modules/fancyindex
git clone --quiet https://github.com/arut/nginx-dav-ext-module.git /usr/local/src/nginx/modules/nginx-dav-ext-module
git clone --quiet --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx.git /usr/local/src/nginx/modules/nginx-modsec-connect
git clone --quiet https://github.com/openresty/memc-nginx-module.git /usr/local/src/nginx/modules/memc-nginx-module
git clone --quiet https://github.com/openresty/echo-nginx-module.git /usr/local/src/nginx/modules/echo-nginx-module

echo "Done"
