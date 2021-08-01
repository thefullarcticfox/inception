all:
	docker-compose -f ./srcs/docker-compose.yml build

start:
	docker-compose -f ./srcs/docker-compose.yml up

clean:
	docker-compose -f ./srcs/docker-compose.yml down

re: clean all
