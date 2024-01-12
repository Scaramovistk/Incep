NAME = inception
SRCS = ./srcs/
COMPOSE = ./srcs/docker-compose.yml
URL = gscarama.42.fr

RESET = \033[0m
GREEN = \033[0;32m

all: conf up

conf:
	@echo "$(GREEN)Creating data directory...$(RESET)\n"
	@mkdir -p /home/gscarama/data/mysql /home/gscarama/data/wordpress
	@echo "$(GREEN)Setting url as host...$(RESET)\n"
	@sudo sed -i '/^127.0.0.1/ {/gscarama.42.fr/! s/localhost/localhost gscarama.42.fr/}' /etc/hosts
	@echo "\n"
	@echo "$(GREEN)Composing...$(RESET)"

up:
	@docker-compose -p $(NAME) -f $(COMPOSE) up --build

start:
	@docker-compose -p $(NAME) stop

clean:
	@docker system prune -af

fclean: clean
	@sudo rm -rf ~/data

re: fclean conf up

