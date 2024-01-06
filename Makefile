NAME = inception
SRCS = ./srcs/
COMPOSE = ./srcs/docker-compose.yml
URL = gscarama.42.fr

RESET = \033[0m
GREEN = \033[0;32m

all: conf up

conf:
	@echo "$(Green)Creating data directory...$(RESET)\n"
	@mkdir -p /home/gscarama/data/mysql /home/gscarama/data/wordpress
	@echo "$(Green)Setting url as host...$(RESET)\n"
	@sudo sed -i '/^127.0.0.1/ {/gscarama.42.fr/! s/localhost/localhost gscarama.42.fr/}' /etc/hosts
	@echo "\n"
	@echo "$(Green)Composing...$(RESET)"

up:
	@docker-compose -p $(NAME) -f $(COMPOSE) up --build

start:
	@docker-compose -p $(NAME) stop

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $(docker network ls -q) 2>/dev/null;\

fclean: clean
	@sudo rm -rf ~/data
	@docker system prune

re: fclean conf up

