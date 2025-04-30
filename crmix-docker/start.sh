#!/bin/bash
eval $(ssh-agent)
/var/www/html/shared/expect-ssh-add
#rm /var/www/html/shared/expect-ssh-add
cd /var/www/html/current && /bin/composer install --no-dev
/usr/local/bin/apache2-foreground
