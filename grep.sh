#!/bin/bash
clear
function menu(){
opcao=$( dialog						\
	--stdout					\
	--title "MENU"					\
	--menu "Escolha uma opção"			\
	0 0 0						\
	1 "Instalar Aplicativos"			\
	2 "Apagar Aplicativos"				\
	3 "Exporta GITHUB"				\
	4 "Atualizar Aplicativo"			\
	5 "Atualizar Repositorios"			\
	6 "voltar")
case $opcao in 
	1) instapk ;;
	2) apgAPK ;;
	3) expGIT ;;
	4) atlAPK ;;
	5) atlREP ;;
	6) bash /Projeto/menu.sh ;;	
	*) exit 0 ;;
esac
}
function instapk(){
APK=$( dialog						\
	--stdout					\
	--title "Instalar aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	0 0)
apt-get install $APK
	( dialog 					\
	--title "Instalando aplicativo"			\
	--gauge "Instalando aplicativo"			\
	0 0)
}
function apgAPK(){
APG=$( dialog						\
	--stdout					\
	--title "Remover aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	0 0)
apt-get remove $APG
}
function expGIT(){
apt-get install git
}
function atlAPK(){
apt-get update 
}
function atlAPK(){
apt-get upgrade
}
menu
