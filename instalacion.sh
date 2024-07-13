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
systemctl status nginx.service
