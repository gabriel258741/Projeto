#!/bin/bash
opcao=$( dialog						\
	--stdout					\
	--title "Menu"					\
	--menu "Escolha um gerenciador:" 		\
	0 0 0						\
	1 "Gerenciador de Arquivos"			\
	2 "Gerenciador de Usuários"			\
	3 "Gerenciados de Redes"			\
	4 "Gerenciador de Dispositivos"			\
	5 "Gerenciador de repositórios"	)
case $opcao in
	1) ./garq.sh ;;
	2) ./gusr.sh ;;
	3) ./gred.sh ;;
	4) ./gdis.sh ;;
	5) ./grep.sh ;;
	*) exit 0
esac
