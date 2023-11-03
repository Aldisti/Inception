domain='adi-stef.42.fr'

mkdir -p /var/www/$domain/html
chmod -R 755 /var/www/$domain

cp /tmp/index.html /var/www/$domain/html/index.html
cp /tmp/server.conf /etc/nginx/sites-available/$domain
rm -f /tmp/index.html /tmp/server.conf

ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/

systemctl restart nginx # restart nginx

