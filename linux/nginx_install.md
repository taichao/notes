yum install autoconf automake zlib zlib-devel openssl openssl-devel pcre pcre-devel gcc

./configure --user=www --group=www \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--with-mail \
--with-mail_ssl_module \
--add-module=../ngx_cache_purge-2.2
make & make install


转载:http://www.cnblogs.com/kreo/p/4378086.html
