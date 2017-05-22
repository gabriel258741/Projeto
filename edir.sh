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
			aoo=$( dialog				\
				--stdout		\
				--menu "Confirmação"	\
			0 0 0				\
			1 "Amor"			\
			2 "Ódio" )
				case $aoo in
					1) dialog --msgbox "Acesso permitido" 0 0; adon ;;
					2) dialog --title "Acesso Negado" --msgbox "Onde não há amor, não há acesso" 0 0 ; menu;;
					*) dialog --msgbox "Erro $?" 0 0 ;;
				esac
		else
			aoo=$( dialog				\
					--stdout		\
					--menu "Confirmação"	\
					0 0 0			\
					1 "Amor"		\
					2 "Ódio" )
				case $aoo in
					1) dialog --msgbox "Acesso permitido" 0 0; bash /Projeto/aper.sh ;;
					2) dialog --title "Acesso Negado" --msgbox "Onde não há amor, não há acesso" 0 0 ; menu;;
					*) dialog --msgbox "Erro $?" 0 0 ;;
				esac
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
	7 "Voltar para o diretório anterior acessado"	\
	8 "Copiar arquivo/diretório"			\
	9 "Mover arquivo/diretório"			\
	10 "Alterar dono"				\
	11 "Alterar permissões"				\
	12 "Agrupar arquivos/diretórios"			\
	13 "Desagrupar arquivos/diretórios"		\
	14 "Compactar Arquivo/Diretório"		\
	15 "Descompactar Arquivo/Diretório"		\
	16 "Editar arquivo"				\
	17 "Voltar" )
case $opcao in
	1) carq ;;
	2) aarq ;;
	3) cdir ;;
	4) adir ;;
	5) bash /Projeto/list.sh ;;
	6) edir ;;
       	7) cd -; bash /Projeto/menu.sh;;
	8) copa ;;
	9) mova ;;
	10) n="d"; entrar ;;
	11) n="p"; entrar ;;
	12) x=0 ; name=$( dialog			\
		--stdout				\
		--title "Agrupar arquivos/diretórios"	\
		--inputbox "Nome do arquivo final:"	\
		0 0 ); aaed;;
	13) daed ;;
	14) comp ;;
	15) desc ;;
	16) edit ;;
	17) bash /Projeto/menu.sh ;;
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
	0) dialog --msgbox "O diretório ja existe" 0 0; cd -; cdir;;
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
	0) cd -; rmdir $arq;;
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
function copa(){
origem=$( dialog 						\
		--stdout				\
		--title "Copiar arquivo/diretório"	\
		--inputbox "Nome (origem):"		\
		0 0 )
destino=$( dialog 					\
		--stdout				\
		--title "Copiar arquivo/diretório"	\
		--inputbox "Destino:"			\
		0 0 )
cp $origem $destino
case $? in
	0) dialog --msgbox "Arquivo/diretório copiado com sucesso" 0 0 ; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ;menu ;;
esac
}
function mova(){
origem=$( dialog 						\
		--stdout				\
		--title "Mover arquivo/diretório"	\
		--inputbox "Nome (origem):"		\
		0 0 )
destino=$( dialog 					\
		--stdout				\
		--title "Mover arquivo/diretório"	\
		--inputbox "Destino:"			\
		0 0 )
mv $origem $destino
case $? in
	0) dialog --msgbox "Arquivo/diretório movido com sucesso" 0 0 ; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ; menu;;
esac
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
	0) menu2;;
	1) dialog					\ 
	--msgbox "Diretório não encontrado, tente novamente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;
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
	1) nome[$x]=$( dialog				\ 
		--stdout 				\
		--title "Adicionar arquivo/diretório" 	\
		--inputbox "Nome:" 0 0 ); let x=($x+1); aaed;;
	2) tar -cvf $name.tar ${nome[@]} > /tmp/agrupar.txt; dialog	\
		--textbox /tmp/agrupar.txt 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function daed(){
arq=$( dialog 						\
		--stdout				\
		--title "Nome do arquivo"		\
		--inputbox "Nome(Não coloque a extensão .tar no final do arquivo"	\
		0 0 )
tar -xvf $arq.tar > /tmp/desagrupar.txt
case $? in
	0) dialog --textbox /tmp/desagrupar.txt 0 0; dialog 	\
		--msgbox "Extraido com sucesso" 0 0; menu;;
	1) dialog 						\
	--msgbox "Impossivel extrair arquivo, arquivo não existe" 0 0; daed;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function comp(){
arq=$( dialog							\
		--stdout					\
		--title "Compactar arquivo/diretório"		\
		--inputbox "Nome/local:"			\
		0 0 )
cd $arq
numero=$?
case $? in
	0) cd -; arq2=$( dialog					\
				--stdout			\
				--title "Compactar diretório"	\
				--inputbox "Nome do arquivo final:" \
				0 0 ); tar -czf $arq2.tar.gz $arq; num2=$?;;
	1) gzip $arq; num2=$?;;
	*) dialog --msgbox "Erro $?" 0 0;;
esac
case $numero in
	0|1) dialog --msgbox "Compactado com sucesso" 0 0; menu;;
	*) dialog --msgbox "erro $?" 0 0; menu;;
esac
case $num2 in
	0) dialog --msgbox "Compactado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel compactar" 0 0; menu;;
	*) dialog --msgbox "erro $?" 0 0; menu;;
esac
}
menu
