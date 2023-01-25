up:
	docker-compose up --build

restart:
	docker-compose down
	docker volume rm $$(docker volume ls -q) -f
	docker-compose up --build

clean:
	docker-compose down
	docker image rm $$(docker image ls -q) -f
	docker volume rm $$(docker volume ls -q) -f

hard-restart:
	make clean
	make up
