#!/bin/bash

# Define versions
OPTIM_NGINX_VER=18.0
NGINX_VER=1.17.0
LIBRESSL_VER=2.9.0
OPENSSL_VER=1.1.1a
NPS_VER=1.13.35.2
HEADERMOD_VER=0.33
LIBMAXMINDDB_VER=1.3.2
GEOIP2_VER=3.2
HTTP_REDIS_VER=0.3.9
PCRE_NGINX_VER=8.42
ZLIB_NGINX_VER=1.2.11

echo "Installing NGINX"
sleep 3
		
        # Nginx installation from source does not add an init script for systemd and logrotate
		# Using the official systemd script and logrotate conf from nginx.org
		
if [[ ! -e /lib/systemd/system/nginx.service ]]; then
			cd /lib/systemd/system/ || exit 1
			wget https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/conf/nginx.service
			# Enable nginx start at boot
			systemctl enable nginx
fi
		
        sleep 3
		
if [[ ! -e /etc/logrotate.d/nginx ]]; then
			cd /etc/logrotate.d/ || exit 1
			wget https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/conf/nginx-logrotate -O nginx
fi
		sleep 3
		
# Nginx's cache directory is not created by default
if [[ ! -d /var/cache/nginx ]]; then
			mkdir -p /var/cache/nginx
		fi
		sleep 3

# We add the sites-* folders as some use them.
		if [[ ! -d /etc/nginx/sites-available ]]; then
			mkdir -p /etc/nginx/sites-available
		fi
		if [[ ! -d /etc/nginx/sites-enabled ]]; then
			mkdir -p /etc/nginx/sites-enabled
		fi
		if [[ ! -d /etc/nginx/conf.d ]]; then
			mkdir -p /etc/nginx/conf.d
		fi
        if [[ ! -d /etc/nginx/modsec ]]; then
			mkdir -p /etc/nginx/modsec
		fi
		echo "NGINX Installed"
		sleep 3

echo "NGINX Installed"
		sleep 3
        	if [[ ! -e /etc/nginx/modsec/modsecurity.conf ]]; then
			echo "ModSecurity Configuration Starts"
            		cd /etc/nginx/modsec/ || exit 1
			wget https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/unicode.mapping || exit 1
            		wget -O modsecurity.conf https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v3/master/modsecurity.conf-recommended || exit 1
            		sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/nginx/modsec/modsecurity.conf || exit 1
			echo "Cleaning Directory"
			rm -rf /opt/owasp-modsecurity-crs || exit 1 
            		cd /opt/ || exit 1
			echo "Directory Cleaned"
            		git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git || exit 1
            		cd owasp-modsecurity-crs/ || exit 1
            		cp -R rules/ /etc/nginx/modsec/ || exit 1
			echo "Copying configuration file to nginx directory"
            		cp /opt/owasp-modsecurity-crs/crs-setup.conf.example /etc/nginx/modsec/crs-setup.conf
            		touch /etc/nginx/modsec/main.conf || exit 1
	    		echo "Include "/etc/nginx/modsec/modsecurity.conf"" | sudo tee -a /etc/nginx/modsec/main.conf || exit 1
	    		echo "Include "/etc/nginx/modsec/crs-setup.conf"" | sudo tee -a /etc/nginx/modsec/main.conf || exit 1
	    		echo "Include "/etc/nginx/modsec/rules/*.conf"" | sudo tee -a /etc/nginx/modsec/main.conf || exit 1
			echo "ModSecurity Configuration Complete"
		fi

        echo "Done"
