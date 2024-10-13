#!/bin/bash
directorio=$(pwd)
while true
do
    clear
    echo "INSTALACION DE VIDEO STREAMING V2"
    echo "----------------------------------------------"
    echo "MENU SCRIPT V.2 | Ubuntu 20.04 y Ubuntu 24.04"
    echo "1. Verificar versión de Ubuntu"
    echo "2. Instalación para Ubuntu 20.04"
    echo "3. Instalación para Ubuntu 24.04"
    echo "4. Remover instalación de Nginx y modulo RTMP"
    echo "5. Renovar SSL (Solo si tienes dominio y certificados instalados)"
    echo "6. Salir del Menú"
    echo "Escoge opción: "
    read seleccionSO

    case $seleccionSO in
        1)
            clear
            lsb_release -a
            echo "Verifica tu version de Ubuntu y presiona [ENTER] para continuar . . . "
            read
            ;;
        2)
            clear
            echo "Iniciando instalación para Ubuntu 20.04..."
            # Aquí inicia el código para la instalación en Ubuntu 20.04
            sleep 5
            apt update && apt upgrade -y && apt autoremove && apt autoclean
            apt install net-tools traceroute iftop -y
            apt-get install libpcre3 unzip libssl-dev build-essential libpcre3-dev zlib1g* -y
            clear
            tar -zxvf nginx-1.20.0.tar.gz
            tar -zxvf nginx-rtmp-module.tar.gz
            #unzip master.zip
            cd nginx-1.20.0
            ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module
            make && make install
            cd /tmp/
            wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
            chmod +x /etc/init.d/nginx
            update-rc.d nginx defaults
            systemctl start nginx.service && systemctl enable nginx
            mkdir /HLS
            mkdir /HLS/live
            mkdir /HLS/mobile
            mkdir /video_recordings
            chmod -R 777 /video_recordings
            cp /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.back
            cd $directorio
            cat /dev/null > /usr/local/nginx/conf/nginx.conf
            cat nginx_conf/nginx_inicial.conf > /usr/local/nginx/conf/nginx.conf
            clear
            systemctl restart nginx.service
            cat /dev/null > /usr/local/nginx/html/index.html
            cat nginx_conf/streaming.html > /usr/local/nginx/html/index.html
            echo "acabamos de cambiar el archivo index.html"
            sleep 1
            echo "Ahora tendras que cambiar tu ip de red o el nombre de tu dominio en el archivo html"
            sleep 5
            nano /usr/local/nginx/html/index.html
            systemctl restart nginx.service
            sleep 3
            clear
            while true
            do
                clear
                echo "INSTALACION DE VIDEO STREAMING V2"
                echo "----------------------------------------"
                echo "1. Instalar Snapd y Certificados (En algunos Cloud ya está instalado Snapd)"
                echo "2. Salir - Dejar Solo la Instalación Local de Pruebas"
                echo "Escoge opcion: "
                read ubuntu20
                case $ubuntu20 in
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
                        cat nginx_conf/nginx_con_ssl.conf > /usr/local/nginx/conf/nginx.conf
                        systemctl start nginx
                        break
                        ;;

                    2)
                        break
                        ;;
                    *)
                        echo "Opción inválida, intenta de nuevo."
                        ;;
                esac
                break
            done
            echo "Instalación completada."
            sleep 3
            break
            ;;
        3)
            clear
            echo "Iniciando instalación para Ubuntu 24.04..."
            sleep 3
            # Aquí inicia el código para la instalación en Ubuntu 24.04
            sleep 5
            apt update && apt upgrade -y && apt autoremove && apt autoclean
            apt install net-tools traceroute iftop -y
            apt-get install libpcre3 unzip libssl-dev build-essential libpcre3-dev zlib1g* -y
            clear
            tar -zxvf nginx-1.26.2.tar.gz
            tar -zxvf nginx-rtmp-module.tar.gz
            #unzip master.zip
            cd nginx-1.26.2
            ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module
            make && make install
            cd /tmp/
            wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
            chmod +x /etc/init.d/nginx
            update-rc.d nginx defaults
            systemctl start nginx.service && systemctl enable nginx
            mkdir /HLS
            mkdir /HLS/live
            mkdir /HLS/mobile
            mkdir /video_recordings
            chmod -R 777 /video_recordings
            cp /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.back
            cd $directorio
            cat /dev/null > /usr/local/nginx/conf/nginx.conf
            cat nginx_conf/nginx_inicial.conf > /usr/local/nginx/conf/nginx.conf
            clear
            systemctl restart nginx.service
            cat /dev/null > /usr/local/nginx/html/index.html
            cat nginx_conf/streaming.html > /usr/local/nginx/html/index.html
            echo "acabamos de cambiar el archivo index.html"
            sleep 1
            echo "Ahora tendras que cambiar tu ip de red o el nombre de tu dominio en el archivo html"
            sleep 5
            nano /usr/local/nginx/html/index.html
            systemctl restart nginx.service
            sleep 3
            clear
            while true
            do
                clear
                echo "INSTALACION DE VIDEO STREAMING V2"
                echo "----------------------------------------"
                echo "1. Instalar Snapd y Certificados (En algunos Cloud ya está instalado Snapd)"
                echo "2. Salir - Dejar Solo la Instalación Local de Pruebas"
                echo "Escoge opcion: "
                read ubuntu24
                case $ubuntu24 in
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
                        cat nginx_conf/nginx_con_ssl.conf > /usr/local/nginx/conf/nginx.conf
                        systemctl start nginx
                        break
                        ;;

                    2)
                        break
                        ;;
                    *)
                        echo "Opción inválida, intenta de nuevo."
                        ;;
                esac
                break
            done

            echo "Instalación completada."
            break
            ;;
        4)
            echo "¿Estás seguro de eliminar NGINX y RTMP? S / N: "
            read remover

            if [[ $remover == "S" || $remover == "s" ]]; then
                echo "Removiendo NGINX y RTMP..."
                sleep 3
                systemctl stop nginx
                service nginx destroy
                update-rc.d nginx remove
                rm -rfv /etc/init.d/nginx
                rm -rfv /usr/local/nginx/
                apt purge python3-distupgrade ubuntu-release-upgrader-core>
                rm -rf $directorio/.chache/*.*
                apt autoclean && apt autoremove
                clear
                echo "Espera un momento, estamos restableciendo los reposi>
                sleep 5
                apt update && apt upgrade -y
                
            elif [[ $remover == "N" || $remover == "n" ]]; then
                echo "No se realizará la eliminación."
                sleep 3
            else
            echo "Ingresa una opción válida y vuelve a intentar..."
            sleep 3
            fi
            ;;
        5)
            systemctl stop nginx.service
            echo "Ingresa el nombre del dominio del streaming . . . "
            read dominio
            certbot renew --dry-run
            cat /etc/letsencrypt/live/$dominio/cert.pem > /usr/local/nginx/ssl/cert.pem
            cat /etc/letsencrypt/live/$dominio/privkey.pem > /usr/local/nginx/ssl/cert.key
            systemctL restart nginx.service
            echo "¡Certificados Actualizados!"
            sleep 3
            ;;
        6)
            echo "¡Hasta Pronto! Gracias por usar este script . . ."
            echo ""
            sleep 1
            break
            ;;
        *)
            echo "Opción inválida, intenta de nuevo."
            sleep 3
            ;;
    esac
done
