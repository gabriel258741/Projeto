#!/bin/bash
# As informações são a mesma do script: list.sh
# Porém contém alterações para chamar scripts secundários
function menu(){
opcao=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--menu "Como deseja listar?"	 		\
	0 0 0						\
	1 "Mostrar apenas o conteúdo"			\
	2 "Mostrar tamanho em KBytes"			\
	3 "Mostrar arquivos ocultos"			\
	4 "Mostrar permissões/grupos/donos/modificações"\
	5 "Voltar" )
case $opcao in
	1) list1 ;;
	2) list2 ;;
	3) list3 ;;
	4) list4 ;;
	5) bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh ;;
	*) bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh ;;
esac
}
function list1(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
case $? in
	1|255) menu;;
esac
ls $arq > /tmp/listar.txt
case $? in
	0) dialog	 					\
		--title "Listagem"				\
		--textbox /tmp/listar.txt 0 0; menu;;
	2) dialog						\
		--msgbox "Diretório não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function list2(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
case $? in
	1|255) menu;;
esac
ls -la $arq > /tmp/listar.txt
case $? in
	0) dialog	 					\
		--title "Listagem"				\
		--textbox /tmp/listar.txt 0 0; menu;;
	2) dialog						\
		--msgbox "Diretório não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function list3(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
case $? in
	1|255) menu;;
esac
ls -a $arq > /tmp/listar.txt
case $? in
	0) dialog	 					\
		--title "Listagem"				\
		--textbox /tmp/listar.txt 0 0; menu;;
	2) dialog						\
		--msgbox "Diretório não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function list4(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
case $? in
	1|255) menu;;
esac
ls -lah $arq > /tmp/listar.txt
case $? in
	0) dialog	 					\
		--title "Listagem"				\
		--textbox /tmp/listar.txt 0 0; menu;;
	2) dialog						\
		--msgbox "Diretório não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
menu
