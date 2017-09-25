#!/bin/sh
echo "Initiating HowServe Express 0.1.2" && sleep 1
apt-get install nginx -y && mkdir /etc/nginx/logs/ && touch /etc/nginx/logs/error_nginx.log && rm /etc/nginx/nginx.conf && sudo wget -P /etc/nginx/ https://privacdn.com/howserv/nginx.conf && truncate -s 0 /etc/nginx/sites-available/default && printf 'server {\nlisten 80;\nroot /var/www/html;\n\nserver_name _;\nindex index.php index.html index.htm;\n\nlocation / {\ntry_files $uri $uri/ /$uri.php$is_args$args;\n}\n\nlocation ~\.php$ {\ninclude snippets/fastcgi-php.conf;\nfastcgi_pass unix:run/php/php7.1-fpm.sock;\n}\n}' > /etc/nginx/sites-available/default && add-apt-repository -y ppa:ondrej/php && apt-get update && apt-get install -y php7.1-fpm php7.1-cli php7.1-curl php7.1-mysql php7.1-sqlite3 php7.1-gd php7.1-xml php7.1-mcrypt php7.1-mbstring php7.1-iconv && sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.1/fpm/php.ini && systemctl restart php7.1-fpm && service nginx restart && clear && rm /var/www/html/index.nginx-debian.html && echo "<?php echo 'Hello, world!' ?>" >> /var/www/html/index.php && mkdir /var/www/html/php/ && echo "<?php phpinfo() ?>" >> /var/www/html/php/index.php && rm ./hsrv.sh && reboot