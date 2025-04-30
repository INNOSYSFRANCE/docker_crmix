# Getting Started

Déploiement de CRMix utilisant Ansible, Ansistrano et Docker.

## TODO

DOCKER : Variabilisé le hash de vérification du script "composer-setup.php" ou trouver une autre solution (mieux gérer son installation ...)

Role docker

Ne pas avoir besoin de reconstruire toute l'image docker à chaque release
Executer composer dans le container Docker
 - Composer doit être exécuter dans le contexte d'un container pour utiliser une version compatible de PHP
 - Le code doit déjà avoir été déployé via Ansistrano pour être utilisé dans le container
 - L'image utilisé par le container doit être build à l'avance avec le code inclus (pas de volume possible dans un build)
 - Utiliser ADD pour ajouter le code plutôt que COPY" ??


## Pre-requis

 - Installer git, docker, ansible (>=2.8), ansistrano
 - Avoir accès au dépôt Github CRMix
 - Copier dans le repertoire une clef privée ayant accès à innocore

## Configuration

### Ansible

#### crmix-ansistrano

exemple de lancement : ansible-playbook crmix.yaml  -i environments/hosts.prod --vault-password-file vault.pass -K 

##### Requirements

- avoir les roles ansistrano installés (ansible-galaxy install ansistrano.deploy ansistrano.rollback)
- Utiliser un utilisateur sur la cible ayant accès à CRMix
- Configurer le serveur apache de la cible (ou utiliser Docker).
- Avoir le thème metronic disponible via le chemin /var/www/theme/metronic_v4.7.5/theme/assets/
- Définir la variable "ansistrano_deploy_to"
- Définir la variable "crmix_keep_releases"

##### Role Variables

ansistrano_deploy_to: Emplacement du code envoyé sur la cible
ansistrano_keep_releases: Nombre de release a garder


install_vendor: (yes|no) Execution automatique de "composer install"
git_pull_deploy: (yes|no) Redéploiement du code (git pull)
force_rebuild: (yes|no) Reconstruiction de l'image docker

## Utilisation

Il faut monter 2 volumes :
 - Le thême
 - l'accès au documents sur prod1


## Action manuel
le service cron ne fonctionne pas corectement après une mise en prod.
il faut se connecter dans le container et reboot le service :
- connexion sur le serveur (prod1b)
- connexion au container : docker exec -ti crmix /bin/bash
- restart du service cron : /etc/init.d/cron restart

### Utilisation de Docker en stand-alone

Exemple pour l'execution sur prod1b :
`docker run -d --name crmix -p 8080:80 -v /var/www/metronic_v4.7.5/theme/assets:/var/www/theme/metronic_v4.7.5/theme/assets -v /var/www/documents_prod1:/var/www/html/documents crmix`
