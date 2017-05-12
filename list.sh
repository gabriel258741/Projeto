#!/bin/bash
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
	5) ./garq ;;
	*) exit 0 ;;
esac
}
function list1(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
ls $arq > /tmp/listar.txt
dialog 							\
	--title "Listagem"				\
	--textbox /tmp/listar.txt 0 0
menu
}
function list2(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório:"		\
	0 0 )
ls -lh $arq > /tmp/listar.txt
dialog							\
	--title "Listagem"				\
	--textbox /tmp/listar.txt 0 0
menu
}
function list3(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório:"		\
	0 0 )
ls -a $arq > /tmp/listar.txt
dialog							\
	--title "Listagem"				\
	--textbox /tmp/listar.txt 0 0
menu
}
function list4(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório:"		\
	0 0 )
ls -l $arq > /tmp/listar.txt
dialog							\
	--title "Listagem"				\
	--textbox /tmp/listar.txt 0 0
menu
}
menu
