# OptimNGINX
NGINX Install Script Extended (NISE) - A complete NGINX installation script with extra module support and configuration.

# Optional modules/features
- ModSecurity v3
- LibreSSL from source (CHACHA20, ALPN for HTTP/2, X25519, P-521)
- OpenSSL from source (TLS 1.3, CHACHA20, ALPN for HTTP/2, X25519, P-521)
- ngx_pagespeed (Google performance module)
- ngx_brotli (Brotli compression algorithm)
- ngx_headers_more (Custom HTTP headers)
- ngx_http_geoip2_module with libmaxminddb and GeoLite2 databases
- ngx_cache_purge (Purge content from FastCGI, proxy, SCGI and uWSGI caches)
- ngx-fancyindex (Fancy indexes module)

# How to use
Just run this command in your shell to download and run the script, and then just follow the instruction on your screen:

```
cd /tmp; rm ngx.sh; wget https://raw.githubusercontent.com/OptimBro/Advanced-Nginx-Install-Script/master/ngx.sh; chmod +x ngx.sh; bash ngx.sh
```

# Installing WordPress (Optional)
You need to setup WP CLI first
```
cd /web; rm wp.sh; wget https://raw.githubusercontent.com/OptimBro/NGINX-Install-Script-Extentded-NISE/master/wp.sh; chmod +x wp.sh; bash wp.sh
```

Credits: Forked from https://github.com/angristan/nginx-autoinstall (Thanks for the script)
