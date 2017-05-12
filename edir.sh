#!/bin/bash
function menu(){
opcao=$( dialog						\
	--stdout					\
	--title "Gerenciar Diretório"			\
	--menu "O que deseja fazer?"	 		\
	0 0 0						\
	1 "Criar Arquivo"				\
	2 "Apagar arquivo"				\
	3 "criar diretório"				\
	4 "apagar diretório"				\
	5 "listar diretório"				\
	6 "Entrar no diretório"				\
	7 "Alterar dono"				\
	8 "Alterar permissões"				\
	9 "Voltar" )
case $opcao in
	1) carq ;;
	2) aarq ;;
	3) cdir ;;
	4) adir ;;
	5) bash /Projeto/list.sh ;;
       	6) n="d"; entrar ;;
	7) n="p"; entrar ;;
	8) bash /Projeto/aper.sh ;;
	*) exit 0 ;;
esac
}
function carq(){
arq=$( dialog						\
	--stdout					\
	--title "Criar arquivo"				\
	--inputbox "Digite o nome do arquivo:"		\
	0 0 )
cat $arq
case $? in
	0) dialog --msgbox "O arquivo ja existe" 0 0; carq;;
	1) > $arq; dialog --msgbox "O arquivo foi criado com sucesso" 0 0;;
	*) dialog --msgbox "Não foi possivel criar o arquivo" 0 0;;
esac
menu
}
function aarq(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar arquivo"			\
	--inputbox "Digite o nome do arquivo:"		\
	0 0 )
cat $arq
case $? in
	1) dialog --msgbox "O arquivo não existe" 0 0; aarq;;
	0) rm -rf $arq; dialog --msgbox "O arquivo foi apagado com sucesso" 0 0;;
	*) dialog --msgbox "Não foi possivel apagar o arquivo" 0 0;;
esac
menu
}
function cdir(){
arq=$( dialog						\
	--stdout					\
	--title "Criar diretório"			\
	--inputbox "Digite o nome do diretório:"	\
	0 0 )
cd $arq
case $? in
	0) dialog --msgbox "O diretório ja existe" 0 0; cd ..; cdir;;
	1) mkdir $arq; dialog --msgbox "O diretório foi criado com sucesso" 0 0;;
	*) dialog --msgbox "Não foi possivel criar o diretório" 0 0;;
esac
menu
}
function adir(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar diretório"			\
	--inputbox "Digite o nome do diretório:"	\
	0 0 )
cd $arq
case $? in
	1) dialog --msgbox "O diretório não existe" 0 0; adir;;
	0) cd ..; rmdir $arq;;
esac
if [ $? == "0" ]; then
	dialog --msgbox "O diretório foi apagado com sucesso" 0 0
elif [ $? == "1" ]; then
	dialog --title "Erro" --msgbox "Diretório não está vazio" 0 0
else
	dialog --title "Erro inesperado" --msgbox "Não foi possivel apagar o arquivo" 0 0 
fi
menu
}
function adon(){
arq=$( dialog						\
	--stdout					\
	--title "Alterar dono"				\
	--inputbox "Digite o nome do diretório/arquivo:"\
	0 0 )
arq2=$( dialog						\
	--stdout					\
	--title "Alterar dono"				\
	--inputbox "Digite o nome do dono:"		\
	0 0 )
chown $arq2 $arq
case $? in
	0) dialog --msgbox "Dono alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel alterar o dono" 0 0; adon;;
	*) dialog --msgbox "erro $?" 0 0
esac
}
function edir(){
arq=$( dialog 						\
		--stdout				\
		--title "Entrar no diretório"		\
		--inputbox "Nome/local do diretório:"		\
		0 0 )
cd $arq
case $? in
	0) bash /Projeto/edir.sh;;
	1) dialog --msgbox "Diretório não encontrado, tente novamente" 0 0; edir;;
	*) dialog --msgbox "Erro $?" 0 0;;
esac
}
menu
