#certbot certonly --standalone
echo "Ingresa el nombre del dominio del streaming . . . "
read dominio
certbot renew --dry-run
cat /etc/letsencrypt/live/$dominio/cert.pem > /usr/local/nginx/ssl/cert.pem
cat /etc/letsencrypt/live/$dominio/privkey.pem > /usr/local/nginx/ssl/cert.key
systemctL restart nginx.service
echo "¡Certificados Actualizados!"
echo ""
