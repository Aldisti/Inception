# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adi-stef <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/13 12:22:04 by adi-stef          #+#    #+#              #
#    Updated: 2023/11/13 12:22:25 by adi-stef         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

$(NAME): prepare
	@docker compose -f ./srcs/docker-compose.yml --env-file "./srcs/.env" up

all: $(NAME)

prepare:
	@bash ./srcs/tools/setup.sh

clean:
	@bash ./srcs/tools/clean.sh

fclean: clean
	@bash ./srcs/tools/fclean.sh

re: fclean re


.PHONY: prepare clean fclean re

