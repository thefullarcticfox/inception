all:
	docker-compose -f ./srcs/docker-compose.yml up --build

clean:
	docker-compose -f ./srcs/docker-compose.yml down

re: clean all
