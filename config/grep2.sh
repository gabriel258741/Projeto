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
	6 "Listar Pacotes"				\
	7 "Voltar" )
case $opcao in 
	1) instapk ;;
	2) apgAPK ;;
	3) expGIT ;;
	4) atlAPK ;;
	5) atlREP ;;
	6) lista ;;
	7) bash /Projeto/config/menu2.sh ;;	
	*) exit 0 ;;
esac
}
function instapk(){
APK=$( dialog						\
	--stdout					\
	--title "Instalar aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	0 0)
case $? in
	1) menu;;
	255) menu;;
esac
apt-get --force-yes install $APK -y
case $? in
	0) dialog --msgbox "Instalado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel instalar aplicativo" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
menu
}
function apgAPK(){
APG=$( dialog						\
	--stdout					\
	--title "Remover aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	0 0)
case $? in
	1) menu;;
	255) menu;;
esac
apt-get remove -y $APG
parg
}
function expGIT(){
dialog					\
	--title "Informação"			\
	--yesno "È necessário fazer a instalação do git. Continuar?" 0 0
case $? in
	0) apt-get --force-yes install git -y; menu;;
	1) bash /Projeto/grep2.sh; menu;;
	*) dialog --msgbox "erro $?" 0 0; menu;;
esac
}
function atlAPK(){
apt-get update 
menu
}
function atlAPK(){
apt-get upgrade
menu
}
function parg(){
apt-get purge $APK -y
case $? in
	0) dialog --msgbox "Instalado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel instalar aplicativo" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
menu
}
function lista(){
apt list --installed | nl > /tmp/listapacotes.txt
dialog --textbox /tmp/listapacotes.txt 0 0
menu
}
menu

