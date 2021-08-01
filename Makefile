all:
	docker-compose -v

clean:
	docker -v

re: clean all
