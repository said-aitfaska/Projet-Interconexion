# Auteur: Youssef MINYARI

#!/bin/sh

## Construction des images a partir des Dockerfile
docker build ./Docker/Box_ext -t image_box_ext
docker build ./Docker/Box_int -t image_box_int
docker build ./Docker/Client_int -t image_client_int
docker build ./Docker/Routeur_Entreprises -t image_routeur_entreprises
docker build ./Docker/Routeur_Interco -t image_routeur_interco
docker build ./Docker/Routeur_Particulier -t image_routeur_particulier
docker build ./Docker/Routeur_SiteP -t image_routeur_sitep
docker build ./Docker/Routeur_SiteS -t image_routeur_sites
docker build ./Docker/Serveur_DNS -t image_service_dns
docker build ./Docker/Serveur_FTP -t image_service_ftp
docker build ./Docker/Serveur_VoIP -t image_service_voip
docker build ./Docker/Serveur_Web -t image_service_web
docker build ./Docker/Serveur_VPN -t image_service_vpn
docker build ./Docker/Client_Entreprise -t image_client

## Creation des sous-reseaux de l'AS
# Reseau Entreprises
docker network create --driver=bridge Reseau_Entreprise

# Reseau AS
docker network create --driver=bridge Reseau_AS

# Reseau VPN
docker network create --driver=bridge Reseau_VPN

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
docker run -tid -p 80 --name Routeur_Entreprises --cap-add=NET_ADMIN image_routeur_entreprises
docker network connect Reseau_AS Routeur_Entreprises
docker network connect Reseau_Entreprise Routeur_Entreprises

docker run -tid -p 80 --name Routeur_SiteP --cap-add=NET_ADMIN --cap-add=NET_RAW image_routeur_sitep
docker network connect Reseau_Principal Routeur_SiteP
docker network connect Reseau_Entreprise Routeur_SiteP

docker run -tid -p 80 --name Routeur_SiteS --cap-add=NET_ADMIN image_routeur_sites
docker network connect Reseau_Secondaire Routeur_SiteS
docker network connect Reseau_Entreprise Routeur_SiteS

# Particuliers
docker run -tid -p 80 --name Box_int --cap-add=NET_ADMIN --cap-add=NET_RAW image_box_int
docker network connect Reseau_Particulier Box_int
docker network connect Reseau_Int Box_int

docker run -tid -p 80 --name Box_ext --cap-add=NET_ADMIN image_box_ext
docker network connect Reseau_Particulier Box_ext
docker network connect Reseau_Ext Box_ext

# Routeur d'interconnexion avec les autres AS
docker run -tid -p 80 --name Routeur_Interco --cap-add=NET_ADMIN image_routeur_interco
docker network connect Reseau_AS Routeur_Interco

# Routeur particuliers
docker run -tid -p 80 --name Routeur_Particulier --cap-add=NET_ADMIN image_routeur_particulier
docker network connect Reseau_AS Routeur_Particulier
docker network connect Reseau_Particulier Routeur_Particulier

## Services
#Service Web
# Service $ docker run -dit --name my-running-app -p 8080:80 my-apache2B
docker run -tid -p 8080:80 --name Serveur_Web --cap-add=NET_ADMIN image_service_web
docker network connect Reseau_Principal Serveur_Web

# Service FTP
docker run -tid -p 80 --name Serveur_FTP --cap-add=NET_ADMIN --cap-add=SYS_ADMIN image_service_ftp
docker network connect Reseau_Principal Serveur_FTP

# Service VoIP
docker run -tid -p 5060:5060 --name Serveur_VoIP --cap-add=NET_ADMIN image_service_voip
docker network connect Reseau_Principal Serveur_VoIP

# Service DNS
docker run -tid -p 80 --name Serveur_DNS --cap-add=NET_ADMIN image_service_dns
docker network connect Reseau_Principal Serveur_DNS

# Service VPN
docker run -tid -p 51820:80 --name Serveur_VPN --cap-add=NET_ADMIN --cap-add=SYS_ADMIN image_service_vpn
docker network connect Reseau_Secondaire Serveur_VPN
docker network connect Reseau_VPN Serveur_VPN

## Clients
# Client Box_int
docker run -tid -p 80 --name Client_int --cap-add=NET_ADMIN image_client_int
docker network connect Reseau_Int Client_int
docker network connect Reseau_VPN Client_int

# Client Principal
docker run -tid -p 80 --name Client_Entreprise --cap-add=NET_ADMIN --cap-add=SYS_ADMIN image_client
docker network connect Reseau_Principal Client_Entreprise
