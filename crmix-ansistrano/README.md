Role Name
=========

Rôle pour déployer CRMix via ansistrano

Requirements
------------

- Utiliser un utilisateur sur la cible ayant accès à CRMix
- Configurer le serveur apache de la cible ou utiliser Docker.
- Avoir le thème metronic disponible via le chemin /var/www/theme/metronic_v4.7.5/theme/assets/
- Définir la variable "ansistrano_deploy_to"
- Définir la variable "crmix_keep_releases"

Role Variables
--------------

ansistrano_deploy_to: Emplacement du code envoyé sur la cible
ansistrano_keep_releases: Nombre de release a garder

Dependencies
------------

Ansistrano

Example Playbook
----------------
`
---
- host: all
- include_role:
    name: crmix-ansistrano
`
License
-------

BSD

Author Information
------------------

Thibault GAUJÉ tgauje@innosys.fr
