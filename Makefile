DOCKER_PS		:= $(shell docker ps -a -q)
DOCKER_VOLUMES	:= $(shell docker volume ls -q)
DOCKER_IMAGES	:= $(shell docker image ls -q)

all:
	@mkdir -pv ~/data/db
	@mkdir -pv ~/data/wp
	@docker-compose -f ./srcs/docker-compose.yml build

start:
	@docker-compose -f ./srcs/docker-compose.yml up

clean:
	@docker-compose -f ./srcs/docker-compose.yml down
	@sudo rm -rvf ~/data/db
	@sudo rm -rvf ~/data/wp

cleanall: clean
	@[[ -n "$(DOCKER_PS)" ]]		&& docker rm -f $(DOCKER_PS)			|| echo "No containers"
	@[[ -n "$(DOCKER_VOLUMES)" ]]	&& docker volume rm $(DOCKER_VOLUMES)	|| echo "No volumes"
	@[[ -n "$(DOCKER_IMAGES)" ]]	&& docker image rm -f $(DOCKER_IMAGES)	|| echo "No images"

re: clean all
