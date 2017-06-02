#!/bin/bash
opcao=$( dialog						\
	--stdout					\
	--title "Menu"					\
	--menu "Escolha um gerenciador:" 		\
	0 0 0						\
	1 "Gerenciador de Arquivos"			\
	2 "Gerenciador de Usuários"			\
	3 "Gerenciador de Redes"			\
	4 "Gerenciador de Dispositivos"			\
	5 "Gerenciador de Pacotes"			\
	6 "Sair" )
case $opcao in
	1) bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh;;
	2) bash /Projeto/.config/gerenciador\ de\ usuarios/gusr2.sh;;
	3) bash /Projeto/.config/gerenciador\ de\ redes/gred2.sh;;
	4) bash /Projeto/.config/gerenciador\ de\ dispositivos/gdis2.sh;;
	5) bash /Projeto/.config/gerenciador\ de\ pacotes/grep2.sh;;
	6) exit 0;;
esac
case $? in
	1|255) exit 0;;
esac
# da mesma forma que o script menu.sh
# Porém tem como finalidade gerenciar em outro diretório
# Chamando scripts diferentes
