# update and install packages
apt update && apt upgrade -y
apt install vim curl procps openssl nginx -y

# TSL protocol setup
SSL_PATH="/etc/nginx/ssl"
INFO="/C=IT/ST=Lazio/L=Rome/O=42/OU=42/CN=$DOMAIN_NAME/UID=adi-stef"
mkdir -p "$SSL_PATH"
openssl -req -x509 -nodes -out "$SSL_PATH/certificate.ctr" -keyout "$SSL_PATH/private.key" -subj "$INFO"

# NGINX configuration
mkdir -p "/var/run/nginx"
chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html

