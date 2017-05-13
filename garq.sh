#!/bin/bash
function entrar(){
user="rokukishi"
pass="adglmm"
x=3
while (( $x > 0 )); do
usuario=$( dialog					\
		--stdout				\
		--title "Acesso Adiministrador"		\
		--inputbox "Usuário:" 0 0 )
senha=$( dialog						\
		--stdout				\
		--title "Acesso Adiministrador"		\
		--passwordbox "Senha:" 0 0 )
	if [ $usuario == $user ] && [ $senha == $pass ]; then
		dialog --msgbox "Acesso permitido" 0 0
		if [ $n == "d" ]; then
			adon
		else
			bash /Projeto/aper.sh
		fi
	else
		dialog --msgbox "Acesso negado" 0 0
		let x=($x-1)
	fi
done
dialog --msgbox "Sem acesso superior" 0 0
menu
}
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
	6 "Entrar no diretório"				\
	7 "Alterar dono"				\
	8 "Alterar permissões"				\
	9 "Agrupar arquivos/diretórios"			\
	10 "Desagrupar arquivos/diretórios"		\
	11 "Compactar Arquivo/Diretório"		\
	12 "Descompactar Arquivo/Diretório"		\
	13 "Editar arquivo"				\
	14 "Voltar" )
case $opcao in
	1) carq ;;
	2) aarq ;;
	3) cdir ;;
	4) adir ;;
	5) bash /Projeto/list.sh ;;
	6) edir ;;
       	7) n="d"; entrar ;;
	8) n="p"; entrar ;;
	9) x=0 ; name=$( dialog			\
		--stdout				\
		--title "Agrupar arquivos/diretórios"	\
		--inputbox "Nome do arquivo final:"	\
		0 0 ); aaed;;
	10) daed ;;
	11) comp ;;
	12) desc ;;
	13) edit ;;
	14) bash /Projeto/menu.sh ;;
	*) exit 0 ;;
esac
}
function carq(){
arq=$( dialog						\
	--stdout					\
	--title "Criar arquivo"				\
	--inputbox "Digite o nome/local do arquivo:"		\
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
	--inputbox "Digite o nome/local do arquivo:"		\
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
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
cd $arq
case $? in
	0) dialog --msgbox "O diretório ja existe" 0 0; cd /Projeto; cdir;;
	1) mkdir $arq; dialog --msgbox "O diretório foi criado com sucesso" 0 0;;
	*) dialog --msgbox "Não foi possivel criar o diretório" 0 0;;
esac
menu
}
function adir(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar diretório"			\
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
cd $arq
case $? in
	1) dialog --msgbox "O diretório não existe" 0 0; adir;;
	0) cd /Projeto; rmdir $arq;;
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
	--inputbox "Digite o nome/local do diretório/arquivo:"\
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
function aaed(){
arq=$( dialog 						\
		--stdout				\
		--title "Agrupar arquivos/diretórios"	\
		--menu "Adicionar/Agrupar"		\
		0 0 0					\
		1 "Adicionar arquivo/diretório"		\
		2 "Agrupar"				\
		3 "Voltar" )
case $arq in
	1) nome[$x]=$( dialog --stdout --title "Adicionar arquivo/diretório" --inputbox "Nome:" 0 0 ); let x=($x+1); aaed;;
	2) tar -c $name.tar ${nome[@]};;
	*) dialog --msgbox "Erro $?" 0 0;;
esac
}
function daed(){
arq=$( dialog 						\
		--stdout				\
		--title "Nome do arquivo"		\
		--inputbox "Nome(Não coloque a extensão .tar no final do arquivo"	\
		0 0 )
tar -x $arq.tar
case $? in
	0) dialog --msgbox "Extraido com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel extrair arquivo, arquivo não existe" 0 0; daed;;
	*) dialog --msgbox "Erro $?" 0 0;;
esac
}
menu
