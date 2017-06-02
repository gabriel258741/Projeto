#!/bin/bash
# As informações são as mesmas do script: grep.sh
# Porém contém alterações para chamar scripts secundários
clear
function menu(){
opcao=$( dialog						\
	--stdout					\
	--title "MENU"					\
	--menu "Escolha uma opção"			\
	0 0 0						\
	1 "Instalar Aplicativos"			\
	2 "Apagar Aplicativos"				\
	3 "Importar GITHUB"				\
	4 "Atualizar Aplicativos"			\
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
	7) bash /Projeto/.config/menu2.sh ;;
	*) bash /Projeto/.config/menu2.sh ;;
esac
}
function instapk(){
APK=$( dialog						\
	--stdout					\
	--title "Instalar aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	0 0)
case $? in
	1|255) menu;;
esac
apt-get --force-yes install $APK -y
case $? in
	0) dialog --msgbox "Instalado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel instalar aplicativo" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function apgAPK(){
APG=$( dialog						\
	--stdout					\
	--title "Remover aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	0 0)
case $? in
	1|255) menu;;
esac
apt-get remove -y $APG
case $? in
	0) parg;;
	1) dialog --msgbox "Impossivel remover aplicativo" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function expGIT(){
git > /tmp/gittest.txt
case $? in
	127) gityes;;
	1) gitno;;
esac
}
function gityes(){
dialog					\
	--title "Informação"			\
	--yesno "È necessário fazer a instalação do git. Continuar?" 0 0
case $? in
	0) apt-get --force-yes install git -y; gitno;;
	1) menu;;
	*) menu;;
esac
}
function gitno(){
gite=$( dialog					\
		--stdout			\
		--title "Importar GITHUB"	\
		--inputbox "Nome do usuário:" 0 0 )
case $? in
	1|255) menu;;
esac
gite2=$( dialog					\
		--stdout			\
		--title "Importar GITHUB"	\
		--inputbox "Nome do repositório:" 0 0 )
case $? in
	1|255) menu;;
esac
git clone http://github.com/$gite/$gite2
case $? in
	0) dialog --msgbox "Importado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel importar" 0 0; menu;;
	*) dialog --title "Impossivel importar" --msgbox "Erro $?" 0 0; menu;;
esac
}
function atlREP(){
dialog --title "Isso pode demorar um pouco" --yesno "Deseja continuar?" 0 0
case $? in
	0) apt-get update; volta=$?;;
	1) menu;;
esac
case $volta in
	0) dialog --msgbox "Atualizado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivela atualizar" 0 0; menu;; 
	*) dialog --title "Impossivel atualizar" --msgbox "Erro $?" 0 0; menu;;
esac
}
function atlAPK(){
dialog --title "Isso pode demorar alguns minutos" --yesno "Deseja continuar?" 0 0
case $? in
	0) apt-get upgrade; volta=$?;;
	1) menu;;
esac
case $volta in
	0) dialog --msgbox "Atualizado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivela atualizar" 0 0; menu;; 
	*) dialog --title "Impossivel atualizar" --msgbox "Erro $?" 0 0; menu;;
esac
}
function parg(){
apt-get purge $APK -y
case $? in
	0) dialog --msgbox "Removido com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel remover aplicativo" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function lista(){
apt list --installed | nl > /tmp/listapacotes.txt
dialog --textbox /tmp/listapacotes.txt 0 0
menu
}
menu

