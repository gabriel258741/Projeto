#!/bin/bash
function menu(){
opcao=$( dialog						\
	--stdout					\
	--title "Gerenciador de Arquivo"		\
	--menu "O que deseja fazer?"	 		\
	0 0 0						\
	1 "Criar Arquivo"				\
	2 "Apagar arquivo"				\
	3 "criar diretório"				\
	4 "apagar diretório"				\
	5 "listar diretório"				\
	6 "Alterar dono"				\
	7 "Alterar permissões"				\
	8 "Voltar" )
case $opcao in
	1) carq ;;
	2) aarq ;;
	3) cdir ;;
	4) adir ;;
	5) ./list ;;
       	6) adon ;;
	7) aper ;;
	8) ./menu.sh ;;
	*) exit 0 ;;
esac
}
function carq(){
arq=$( dialog						\
	--stdout					\
	--title "Criar arquivo"				\
	--inputbox "Digite o nome do arquivo:"		\
	0 0 )
> $arq
dialog							\
	--title "Mensagem"				\
	--msgbox "Arquivo criado com sucesso" 0 0
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

