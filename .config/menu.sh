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
	1) bash /Projeto/.config/gerenciador\ de\ arquivos/garq.sh;;
	2) bash /Projeto/.config/gerenciador\ de\ usuarios/gusr.sh;;
	3) bash /Projeto/.config/gerenciador\ de\ redes/gred.sh;;
	4) bash /Projeto/.config/gerenciador\ de\ dispositivos/gdis.sh;;
	5) bash /Projeto/.config/gerenciador\ de\ pacotes/grep.sh;;
	6) exit 0 ;;
esac
case $? in
	1|255) exit 0;;
esac
# Temos aqui o menu completo, onde se pede que o usuário escolha um dos gereciadores disponiveis
# Chamando assim o script de seu gerenciador
# Caso aperte Cancel, ESC ou qualquer outra coisa, o programa será encerrado com retorno 0

