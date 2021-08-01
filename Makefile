all:
	mkdir -p ~/data
	mkdir -p ~/data/db
	mkdir -p ~/data/wp
	docker-compose -f ./srcs/docker-compose.yml build

start:
	docker-compose -f ./srcs/docker-compose.yml up

clean:
	sudo rm -rf ~/data/db
	sudo rm -rf ~/data/wp
	docker-compose -f ./srcs/docker-compose.yml down

re: clean all
