# Variables
NAME = inception
SRCS = ./srcs/
COMPOSE = ./srcs/docker-compose.yml
URL = gscarama.42.fr

# Colors
RESET = \033[0m
GREEN = \033[0;32m

all: conf up

conf:
	@echo "$(Green)Creating data directory...$(RESET)\n"
	@mkdir -p ~/data/database ~/data/wordpress_files
	@echo "$(Green)Setting url as host...$(RESET)\n"
	@sudo sed -i '/^127.0.0.1/ {/diogmart.42.fr/! s/localhost/localhost diogmart.42.fr/}' /etc/hosts
	@echo "\n"
	@echo "$(Green)Composing...$(RESET)"

up:
	@docker-compose -p $(NAME) -f $(COMPOSE) up --build

down:
	@docker-compose -p $(NAME) down --volumes

start:
	@docker-compose -p $(NAME) stop

clean-images:
	docker rmi -f $$(docker images -q) || true

clean: down clean-images

fclean: clean
	@sudo rm -rf ~/data
	@docker system prune

re: fclean conf up

