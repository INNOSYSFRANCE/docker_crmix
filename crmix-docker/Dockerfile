FROM php:7.3.13-apache-buster

#copie du fichier pour cron.d(aily)
#ADD generation_file_paiement.cron /etc/cron.d/generation_file_paiement.cron
ADD generation_file_paiement.sh /usr/local/bin/generation_file_paiement.sh

# Installation des paquets nécessaire au fonctionnement du Dockerfile et de l'appli
# et Activation de l'extension pdo_mysql pour PHP
# et Téléchargement et installation de Composer
RUN apt update && apt install -y ssh-client expect unzip git default-mysql-client cron zip libzip-dev libpng-dev\
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && docker-php-ext-install gd \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" 
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
#    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'c5b9b6d368201a9db6f74e2611495f369991b72d9c8cbd3ffbc63edff210eb73d46ffbfce88669ad33695ef77dc76976') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Copy de la clef pour récupérer innocore et configuration de SSH pour utiliser
# cette clef lors de l'installation des vendors
COPY innocore /root/.ssh/innocore
COPY config /root/.ssh/config

# Execution du script expect pour ne pas avoir rentrer à la main la passphrase
# OLD : maintenant c'est executé par un script via ansible
#COPY expect-ssh-add /root/expect-ssh-add
#RUN chmod u+x /root/expect-ssh-add

# Installation des vendors et nettoyage du script expect
# car il contient la passphrase en claire
WORKDIR /var/www/html/current

# Copie du vhost et activation du module rewrite pour apache et reload du service
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite headers && service apache2 restart

RUN chmod 744  /usr/local/bin/generation_file_paiement.sh
RUN crontab -l | { cat; echo "0 1 * * * bash /usr/local/bin/generation_file_paiement.sh"; } | crontab - && /etc/init.d/cron restart
#RUN crontab -l | { cat; echo "* * * * * echo hello world >> /var/log/crontest.log "; } | crontab -

COPY vendor_install.sh /root/vendor_install.sh
RUN chmod u+x /root/vendor_install.sh 
#CMD ["/root/vendor_install.sh"]

