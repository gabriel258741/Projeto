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
	1) bash /Projeto/edir.sh;;
	2) bash /Projeto/gusr2.sh;;
	3) bash /Projeto/gred2.sh;;
	4) bash /Projeto/gdis2.sh;;
	5) bash /Projeto/grep2.sh;;
	*) exit 0
esac
