#certbot certonly --standalone
certbot renew --dry-run
cat /etc/letsencrypt/live/mi.dominio.com/cert.pem > /usr/local/nginx/ssl/cert.pem
cat /etc/letsencrypt/live/mi.dominio.com/privkey.pem > /usr/local/nginx/ssl/cert.key
systemctL restart nginx.service
