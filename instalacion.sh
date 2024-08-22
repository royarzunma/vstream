directorio=$(pwd)
echo "tu directorio de trabajo es : " $directorio
echo " Ahora espera 5 segundos para comenzar la instalación."
sleep 5
apt update
apt upgrade -y
apt autoremove
apt autoclean
apt install net-tools traceroute iftop -y
apt-get install libpcre3 unzip libssl-dev build-essential libpcre3-dev zlib1g* -y
clear
# echo "Descargaremos los archivos necesarios para comenzar la instalación . . . "
# wget -c https://github.com/arut/nginx-rtmp-module/archive/master.zip
# wget -c https://nginx.org/download/nginx-1.20.0.tar.gz
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
cd $directorio
cat /dev/null > /usr/local/nginx/conf/nginx.conf
cat nginx_inicial.conf > /usr/local/nginx/conf/nginx.conf
clear
systemctl restart nginx.service
cat /dev/null > /usr/local/nginx/html/index.html
cat streaming.html > /usr/local/nginx/html/index.html
echo "acabamos de cambiar el archivo index.html"
sleep 3
echo "Ahora tendras que cambiar el nombre de tu dominio en el archivo html"
sleep 3
nano /usr/local/nginx/html/index.html
systemctl restart nginx.service
sleep 3
clear
while true
do
    clear
    echo "MENU SCRIPT V.1"
    echo "1. Instalar Snapd y Certificados (En algunos Cloud ya está instalado)"
    echo "2. Ya tengo Snapd, solo instalar certificados SSL"
    echo "3. No instalar certificados - estoy reinstlando los servicios"
    echo "4. Salir - Solo Instalación Local de Pruebas"
    echo "Escoge opcion: "
    read opcion
    case $opcion in
        1)
            echo "Instalar SNAP"
            apt install snapd
            clear
            echo "Instalacion Finalizada de Snapd"
            sleep 5
            echo "Ahora continuaremos con la instalacion de Certificados SSL"
            sleep 5
            snap install --classic certbot
            systemctl stop nginx
            certbot certonly --standalone
            mkdir /usr/local/nginx/ssl
            echo "Ingresa el nombre de tu dominio para configurar tus SSL en Nginx"
            read dominio
            cd $directorio
            cat /etc/letsencrypt/live/$dominio/cert.pem > /usr/local/nginx/ssl/cert.pem
            cat /etc/letsencrypt/live/$dominio/privkey.pem > /usr/local/nginx/ssl/cert.key
            cat /dev/null > /usr/local/nginx/conf/nginx.conf
            cat nginx_con_ssl.conf > /usr/local/nginx/conf/nginx.conf
            systemctl start nginx
            break
            ;;

        2)
            echo "Continuar sin Instalar Snap e instalar certificados SSL"
            snap install --classic certbot
            echo "Ahora continuaremos con la instalacion de Certificados SSL"
            sleep 5
            systemctl stop nginx
            certbot certonly --standalone
            mkdir /usr/local/nginx/ssl
            echo "Ingresa el nombre de tu dominio para configurar tus SSL en Nginx"
            read dominio
            cd $directorio
            cat /etc/letsencrypt/live/$dominio/cert.pem > /usr/local/nginx/ssl/cert.pem
            cat /etc/letsencrypt/live/$dominio/privkey.pem > /usr/local/nginx/ssl/cert.key
            cat /dev/null > /usr/local/nginx/conf/nginx.conf
            cat nginx_con_ssl.conf > /usr/local/nginx/conf/nginx.conf
            systemctl start nginx
            break
            ;;
        3) 
            echo "Solo reconfiguraremos las claves y llaves ya instaladas . . ." 
            sleep 5
            echo "Ingresa el nombre de tu dominio para configurar tus SSL en Nginx"
            read dominio
            cd $directorio
            cat /etc/letsencrypt/live/$dominio/cert.pem > /usr/local/nginx/ssl/cert.pem
            cat /etc/letsencrypt/live/$dominio/privkey.pem > /usr/local/nginx/ssl/cert.key
            cat /dev/null > /usr/local/nginx/conf/nginx.conf
            cat nginx_con_ssl.conf > /usr/local/nginx/conf/nginx.conf
            systemctl restart nginx
            break
            ;;
        4) 
            break
            ;;
        *)
            echo "Opción inválida, intenta de nuevo."
            
            ;;
    esac
    break
done

echo "INSTALACIÓN FINALIZADA."
#reboot
