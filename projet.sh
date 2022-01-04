# Auteur: Youssef MINYARI

#!/bin/sh

## Construction des images a partir des Dockerfile
docker build ./Docker/Box_ext -t image_box_ext
docker build ./Docker/Box_int -t image_box_int
docker build ./Docker/Routeur_Entreprises -t image_routeur_entreprises
docker build ./Docker/Routeur_Particulier -t image_routeur_particulier
docker build ./Docker/Routeur_services -t image_routeur_services
docker build ./Docker/Routeur_SiteP -t image_routeur_sitep
docker build ./Docker/Routeur_SiteS -t image_routeur_sites
docker build ./Docker/Serveur_DNS -t image_service_dns
docker build ./Docker/Serveur_FTP -t image_service_ftp
docker build ./Docker/Serveur_VoIP -t image_service_dns
docker build ./Docker/Serveur_VPN -t image_service_vpn
docker build ./Docker/Serveur_Web -t image_service_web


## Creation des sous-reseaux de l'AS
# Reseau Entreprises
docker network create --driver=bridge Reseau_Entreprise

# Reseau AS
docker network create --driver=bridge Reseau_AS

# Reseau Principal d'entreprises 
docker network create --driver=bridge Reseau_Principal

# Reseau Secondaire d'entreprises
docker network create --driver=bridge Reseau_Secondaire

# Reseau Particuliers
docker network create --driver=bridge Reseau_Particulier

# Reseau de particuliers Internes
docker network create --driver=bridge Reseau_Int

# Reseau des particuliers Externes
docker network create --driver=bridge Reseau_Ext

# Reseau Interconnexion
docker network create --driver=bridge Reseau_Interco


## Lancement des conteneurs et connexion aux differents reseaux
# Entreprises
docker run -tid --name Routeur_Entreprises --cap-add=NET_ADMIN image_routeur_entreprises
docker network connect Reseau_AS Routeur_Entreprises
docker network connect Reseau_Entreprise Routeur_Entreprises

docker run -tid --name Routeur_SiteP --cap-add=NET_ADMIN image_routeur_sitep
docker network connect Reseau_Principal Routeur_SiteP
docker network connect Reseau_Entreprise Routeur_SiteP

docker run -tid --name Routeur_SiteS --cap-add=NET_ADMIN image_routeur_sites
docker network connect Reseau_Secondaire Routeur_SiteS
docker network connect Reseau_Entreprise Routeur_SiteS

# Particuliers
docker run -tid --name BOX1 --cap-add=NET_ADMIN image_box1
docker network connect r_fai BOX1

docker run -tid --name BOX2 --cap-add=NET_ADMIN image_box2
docker network connect r_fai BOX2

# Services

# MACHINE1 et 2 : machines du réseau privé de l'entreprise
docker run -tid --name MACHINE1 --cap-add=NET_ADMIN --network r_prive image_machine_prive

docker run -tid --name MACHINE2 --cap-add=NET_ADMIN --network r_prive image_machine_prive

docker network connect r_prive SDHCP

# Routeur d'interconnexion avec les autres AS
docker run -tid --name R1AS --cap-add=NET_ADMIN image_routeur_r1as
docker network connect r_as R1AS

# Serveur web du réseau externe d'entreprise
docker run -tid --name WEB --cap-add=NET_ADMIN image_web
docker network connect r_ext WEB

# Execution de nos scripts pour lancer les applications sur chaque conteneur.
docker exec Routeur_AS /home/start.sh
docker exec R2 /home/start.sh
docker exec R3 /home/start.sh
docker exec R2EX /home/start.sh
docker exec R2EN /home/start.sh
docker exec SDHCP /home/start.sh
docker exec MACHINE1 /home/start.sh
docker exec MACHINE2 /home/start.sh
docker exec WEB /home/start.sh
docker exec BOX1 /home/start.sh
docker exec BOX2 /home/start.sh
