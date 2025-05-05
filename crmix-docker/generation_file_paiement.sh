#!/bin/sh
# execution script php avec renvoie vers log et inscription de la date
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

date >> /tmp/cron_paiement.log
php -f /var/www/html/current/cron/generation_files_paiement.php >> /tmp/cron_paiement.log