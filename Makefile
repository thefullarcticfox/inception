all:
	@mkdir -pv ~/data/db
	@mkdir -pv ~/data/wp
	@docker-compose -f ./srcs/docker-compose.yml build

start:
	@docker-compose -f ./srcs/docker-compose.yml up

clean:
	@sudo rm -rvf ~/data/db
	@sudo rm -rvf ~/data/wp
	@docker-compose -f ./srcs/docker-compose.yml down

re: clean all
