<div class="logo"><img src="Docker.png" width="250px" align="right"></div>


# Interconnexion between AS

## Table of Contents

- [About](#about)
- [Run](#run)
- [License](#license)

## About

<p>We are developing the architectures and algorithms essential to interconnect our autonomous system to other AS.</p>


## Run

Open a terminal, and type :<br>

	cd Bureau//Projet-Interconnexion
	chmod +x projet.sh
	./projet.sh

Here servals dockers will appear representing the whole architecture of our AS 
(Client, DHCP server, routers and servers, etc...).<br>
To stop the dockers, you have to type :<br>

	docker kill  $(docker ps -a -q)  
  
Then, type :<br>

	docker rm  $(docker ps -a -q)
	docker rmi  $(docker images -a -q)
## License

The library is Software released under Apache-2.0 [License](LICENSE.txt).
