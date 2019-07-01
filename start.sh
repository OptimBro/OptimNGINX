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

rm -rf /opt/dep.sh
rm -rf /opt/compile.sh
rm -rf /opt/install.sh

echo "Starting script"
sleep 2
wget -qO /opt/dep.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/dep.sh

chmod +x /opt/dep.sh

bash /opt/dep.sh

echo -ne '#####                     (33%)\r'
sleep 3

echo "Compiling..."
sleep 2
wget -qO /opt/compile.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/compile.sh

chmod +x /opt/compile.sh

bash /opt/compile.sh

echo -ne '#############             (66%)\r'
sleep 3

echo "Installing..."
sleep 2

wget -qO /opt/install.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/install.sh

chmod +x /opt/install.sh

bash /opt/install.sh

echo -ne '#######################   (100%)\r'
echo -ne '\n'

sleep 3

echo "Nginx is ready"
