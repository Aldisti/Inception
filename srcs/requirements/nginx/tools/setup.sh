# update and install packages
apt update && apt upgrade -y
apt install vim curl procps openssl nginx -y

# TSL protocol setup
PATH="/etc/nginx/ssl"
INFO="/C=IT/ST=Lazio/L=Rome/O=42/OU=42/CN=adi-stef.42.fr/UID=adi-stef"
mkdir -p "$PATH"
openssl -req -x509 -nodes -out "$PATH/certificate.ctr" -keyout "$PATH/private.key" -subj "$INFO"

# NGINX configuration
PATH="/var/run/nginx"
mkdir -p "$PATH"
chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html

