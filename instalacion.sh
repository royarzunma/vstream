apt update
apt upgrade -y
apt autoremove
apt autoclean
apt install net-tools traceroute iftop -y
apt-get install libpcre3 unzip libssl-dev build-essential libpcre3-dev zlib1g* -y
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
wget https://nginx.org/download/nginx-1.20.0.tar.gz
tar -zxvf nginx-1.20.0.tar.gz
unzip master.zip
cd nginx-1.20.0
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
make install
cd /tmp/
wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
chmod +x /etc/init.d/nginx
update-rc.d nginx defaults
systemctl start nginx.service
systemctl enable nginx
mkdir /HLS
mkdir /HLS/live
mkdir /HLS/mobile
mkdir /video_recordings
chmod -R 777 /video_recordings
cp /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.back
cd /usr/local/nginx/conf
rm -rf nginx.conf
touch nginx.conf
nano nginx.conf
systemctl restart nginx.service
clear
https://github.com/royarzunma/vstream/blob/main/streaming.html
rm -rf /usr/local/nginx/html/index.html
mv streaming.html /usr/local/nginx/html/index.html
nano /usr/local/nginx/html/index.html
systemctl restart nginx.service
systemctl status snapd
clear

while true
do
    clear
    echo "MENU SCRIPT V.1"
    echo "1. Instalar Snapd (En algunos Cloud ya está instalado)"
    echo "2. Ya tengo Snapd - instalar certificados SSL"
    echo "Escoge opcion: "
    read opcion

    case $opcion in
        1)
            echo "Instalar SNAP"
            apt install snapd
            clear
            echo "Instalacion Finalizada"
            sleep 2
            echo "Ahora continuaremos con la instalacion de Certificados SSL"
            sleep 2
            break
            ;;

        2)
            echo "Continuar sin Instalar Snap e instalar certificados SSL"
            break
            ;;
        *)
            echo "Opción inválida, intenta de nuevo."
            ;;
    esac
    #read -p "Presiona una tecla para continuar..."
    break
done
snap install --classic certbot
systemctl stop nginx
certbot certonly --standalone
echo "Ingresa el nombre de tu dominio para configurar tus SSL en Nginx"
read dominio
mkdir /usr/local/nginx/ssl
cat /etc/letsencrypt/live/$dominio/cert.pem > /usr/local/nginx/ssl/cert.pem
cat /etc/letsencrypt/live/$dominio/privkey.pem > /usr/local/nginx/ssl/cert.key
cat /dev/null > /usr/local/nginx/conf/nginx.conf
cat nginx_con_ssl.conf > /usr/local/nginx/conf/nginx.conf
systemctl start nginx
reboot
