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
	5 "Gerenciador de Pacotes"	)
case $opcao in
	1) bash /Projeto/.config/gerenciador\ de\ arquivos/garq.sh;;
	2) bash /Projeto/.config/gerenciador\ de\ usuarios/gusr.sh;;
	3) bash /Projeto/.config/gerenciador\ de\ redes/gred.sh;;
	4) bash /Projeto/.config/gerenciador\ de\ dispositivos/gdis.sh;;
	5) bash /Projeto/.config/gerenciador\ de\ pacotes/grep.sh;;
	*) exit 0
esac
