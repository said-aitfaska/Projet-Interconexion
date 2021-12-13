
#Auteur : Saïd A.Faska

#!/bin/bash

#Delete the automatical adress configured by the docker image 
ip addr flush dev eth1
ip link set dev eth1 up 
ip a a 120.0.33.66/24 dev eth1

#On doit mettre routage dynamique ???

#On cree un dossier avec nos identifiants et on attribue les droits d'acces
# pour y acceder ensuite dans filezilla
useradd said
echo "said:enseeiht" | chpasswd
mkdir /home/said
chown said /home/said
usermod --shell /bin/bash said
hostname FTP
echo " 120.0.33.65 FTP" >> /etc/hosts
chmod o-w /etc/proftpd/ etc/proftpd/modules.conf etc/proftpd.conf
service proftpd start
MonMsg="BRAVO GROUPE2 VOTRE FTP MARCHE BIEN !"
# Si le service marche bien, lors de la connexion sur filezilla on y trouvera welcome.txt 
# qui contiendra MonMsg 
echo -e "$MonMsg" >> /home/said/welcome.txt

