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
dialog 							\
	--title "Listagem"				\
	--text
menu
}
function aarq(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar arquivo"			\
	--inputbox "Digite o nome do arquivo:"		\
	0 0 )
rm -rf $arq
dialog							\
	--title "Mensagem"				\
	--msgbox "Arquivo apagado com sucesso" 0 0
menu
}
function cdir(){
arq=$( dialog						\
	--stdout					\
	--title "Criar diretório"			\
	--inputbox "Digite o nome do diretório:"	\
	0 0 )
mkdir $arq
dialog							\
	--title "Mensagem"				\
	--msgbox "Diretório criado com sucesso" 0 0
menu
}
function adir(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar diretório"			\
	--inputbox "Digite o nome do diretório:"	\
	0 0 )
rmdir -rf $arq
dialog							\
	--title "Mensagem"				\
	--msgbox "Diretório apagado com sucesso" 0 0
menu
}

