#!/bin/bash

# Define versions
OPTIM_NGINX_VER="18.0"
NGINX_VER="1.17.0"
LIBRESSL_VER="2.9.0"
OPENSSL_VER="1.1.1a"
NPS_VER="1.13.35.2"
HEADERMOD_VER="0.33"
LIBMAXMINDDB_VER="1.3.2"
GEOIP2_VER="3.2"
HTTP_REDIS_VER="0.3.9"
PCRE_NGINX_VER="8.42"
ZLIB_NGINX_VER="1.2.11"

export OPTIM_NGINX_VER
export NGINX_VER
export LIBRESSL_VER
export OPENSSL_VER
export NPS_VER
export HEADERMOD_VER
export LIBMAXMINDDB_VER
export GEOIP2_VER
export HTTP_REDIS_VER
export PCRE_NGINX_VER
export ZLIB_NGINX_VER

rm -rf /opt/optimengine/dep.sh
rm -rf /opt/optimengine/compile.sh
rm -rf /opt/optimengine/install.sh

mkdir -p /opt/optimengine/

wget -qO /opt/optimengine/dep.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/dep.sh
chmod +x /opt/optimengine/dep.sh

wget -qO /opt/optimengine/compile.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/compile.sh
chmod +x /opt/optimengine/compile.sh

wget -qO /opt/optimengine/install.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/install.sh
chmod +x /opt/optimengine/install.sh

cd /opt/optimengine/

./dep.sh
./compile.sh
./install.sh



echo "Nginx is ready"
