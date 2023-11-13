
# TLS protocol setup
# MY_SSL_PATH="/etc/nginx/ssl"
# MY_INFO="/C=IT/ST=Lazio/L=Rome/O=42/OU=42/CN=$DOMAIN_NAME/UID=adi-stef"
# if [ ! -d "$MY_SSL_PATH" ]; then
# 	mkdir -p "$MY_SSL_PATH"
# fi
# openssl req -x509 -nodes -out "$MY_SSL_PATH/certificate.ctr" -keyout "$MY_SSL_PATH/private.key" -subj "$MY_INFO"
# 
# ls -a "$MY_SSL_PATH || $MY_INFO"
# 
# # NGINX configuration
# mkdir -p "/var/run/nginx"
# chmod 755 /var/www/html
# chown -R www-data:www-data /var/www/html

nginx -g 'daemon off;'

