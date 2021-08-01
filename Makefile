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

cleanall: clean
	@docker rm -f $(docker ps -a -q)
	@docker images rm -f $(docker images ls -q)
	@docker volume rm $(docker volume ls -q)

re: clean all
