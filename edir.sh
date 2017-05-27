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
	5 "Mostrar conteúdo de arquivo"			\
	6 "listar diretório"				\
	7 "Entrar no diretório"				\
	8 "Voltar para o diretório anterior"		\
	9 "Copiar arquivo/diretório"			\
	10 "Mover arquivo/diretório"			\
	11 "Alterar dono"				\
	12 "Alterar permissões"				\
	13 "Agrupar arquivos/diretórios"		\
	14 "Desagrupar arquivos/diretórios"		\
	15 "Compactar Arquivo/Diretório"		\
	16 "Descompactar Arquivo/Diretório"		\
	17 "Editar arquivo"				\
	18 "Ir para a raiz"				\
	19 "Voltar para o diretório inicial do gereneciamento"	\
	20 "Voltar para o menu" )
case $opcao in
	1) carq ;;
	2) aarq ;;
	3) cdir ;;
	4) adir ;;
	5) vera ;;
	6) bash /Projeto/list.sh ;;
	7) edir ;;
	8) cd -; menu;;
	9) copa ;;
	10) mova ;;
	11) n="d"; entrar ;;
	12) n="p"; entrar ;;
	13) x=0 ; name=$( dialog			\
		--stdout				\
		--title "Agrupar arquivos/diretórios"	\
		--inputbox "Nome do arquivo final:"	\
		0 0 ); aaed;;
	14) daed ;;
	15) comp ;;
	16) desc ;;
	17) edit ;;
	18) cd /; menu;;
	19) cd /Projeto; bash ./garq.sh;;
	20) bash /Projeto/menu.sh ;;
	*) dialog --msgbox "Opção inválida" 0 0 ; menu;;
esac
}
function carq(){
arq=$( dialog						\
	--stdout					\
	--title "Criar arquivo"				\
	--inputbox "Digite o nome/local do arquivo:"		\
	0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
cat $arq
case $? in
	0) dialog --msgbox "O arquivo ja existe" 0 0; menu;;
	1) > $arq; volta=$?;;
	*) dialog --title "Erro $?" --msgbox "Não foi possivel criar o arquivo" 0 0; menu;;
esac
case $volta in
	0) dialog --msgbox "O arquivo foi criado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel criar o arquivo" 0 0; menu;;
	*) dialgo --title "Erro $?" --msgbox "Não foi possivel criar o arquivo" 0 0; menu;;
esac
}
function aarq(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar arquivo"			\
	--inputbox "Digite o nome/local do arquivo:"		\
	0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
cat $arq
case $? in
	1) dialog --msgbox "O arquivo não existe" 0 0; menu;;
	0) rm -rf $arq; volta=$?;;
	*) dialog --title "Erro $?" --msgbox "Não foi possivel apagar o arquivo" 0 0; menu;;
esac
case $volta in
	0) dialog --msgbox "O arquivo foi apagado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel apagado o arquivo" 0 0; menu;;
	*) dialgo --title "Erro $?" --msgbox "Não foi possivel apagar o arquivo" 0 0; menu;;
esac
}
function cdir(){
arq=$( dialog						\
	--stdout					\
	--title "Criar diretório"			\
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
cd $arq
case $? in
	0) dialog --msgbox "O diretório ja existe" 0 0; cd /Projeto; menu;;
	1) mkdir $arq; volta=$?;;
	*) dialog --msgbox "Não foi possivel criar o diretório" 0 0; menu;;
esac
case $volta in
	0) dialog --msgbox "O diretório foi criado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel apagar o diretório" 0 0; menu;;
	*) dialgo --title "Erro $?" --msgbox "Não foi possivel apagar o diretório" 0 0; menu;;
esac
}
function adir(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar diretório"			\
	--inputbox "Digite o nome/local do diretório:"	\
	0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
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
function vera(){
arq=$( dialog						\
		--stdout				\
		--title "Mostrar conteúdo de arquivo:"	\
		--inputbox "Nome/Origem:" 0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
dialog --title "$arq" --textbox $arq 0 0
case $? in
	0) menu;;
	1) dialog --msgbox "É um diretório" 0 0; menu;;
	255) dialog --msgbox "Arquivo não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function copa(){
arq=$( dialog						\
		--stdout				\
		--menu 					\
		0 0 0					\
		1 "Arquivo"				\
		2 "Diretório"
		3 "Voltar" )
case $arq in
	1) car;;
	2) cdr;;
	3) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function car(){
origem=$( dialog 					\
		--stdout				\
		--title "Copiar arquivo"	\
		--inputbox "Nome (origem):"		\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
destino=$( dialog 					\
		--stdout				\
		--title "Copiar arquivo"	\
		--inputbox "Destino:"			\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
cp $origem $destino
case $? in
	0) dialog --msgbox "Arquivo copiado com sucesso" 0 0 ; menu;;
	1) dialgo --msgbox "Arquivo ou destino não encontrados" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ; menu;;
esac
}
function cdr(){
origem=$( dialog 					\
		--stdout				\
		--title "Copiar diretório"	\
		--inputbox "Nome (origem):"		\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
destino=$( dialog 					\
		--stdout				\
		--title "Copiar diretório"	\
		--inputbox "Destino:"			\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
cp -r $origem $destino
case $? in
	0) dialog --msgbox "Diretório copiado com sucesso" 0 0 ; menu;;
	1) dialgo --msgbox "Diretório ou destino não encontrados" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ; menu;;
esac
}
function mova(){
origem=$( dialog 						\
		--stdout				\
		--title "Mover arquivo/diretório"	\
		--inputbox "Nome (origem):"		\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
destino=$( dialog 					\
		--stdout				\
		--title "Mover arquivo/diretório"	\
		--inputbox "Destino:"			\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
mv $origem $destino
case $? in
	0) dialog --msgbox "Arquivo/diretório movido com sucesso" 0 0 ; menu;;
	1) dialog --msgbox "Arquivo/diretório ou destino não encontrado" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ; menu;;
esac
}
function adon(){
arq=$( dialog						\
	--stdout					\
	--title "Alterar dono"				\
	--inputbox "Digite o nome/local do diretório/arquivo:"\
	0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
arq2=$( dialog						\
	--stdout					\
	--title "Alterar dono"				\
	--inputbox "Digite o nome do dono:"		\
	0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
chown $arq2 $arq
case $? in
	0) dialog --msgbox "Dono alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel alterar o dono" 0 0; adon;;
	*) dialog --msgbox "erro $?" 0 0; adon;;
esac
}
function edir(){
arq=$( dialog 						\
		--stdout				\
		--title "Entrar no diretório"		\
		--inputbox "Nome/local do diretório:"		\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
cd $arq
case $? in
	0) menu;;
	1) dialog --msgbox "Diretório não encontrado, tente novamente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
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
	2) tar -cvf $name.tar ${nome[@]} > /tmp/agrupar.txt; dialog --textbox /tmp/agrupar.txt 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function daed(){
arq=$( dialog 						\
		--stdout				\
		--title "Nome do arquivo"		\
		--inputbox "Nome(Não coloque a extensão .tar no final do arquivo"	\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
tar -xvf $arq.tar > /tmp/desagrupar.txt
case $? in
	0) dialog --textbox /tmp/desagrupar.txt 0 0; dialog --msgbox "Extraido com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel extrair arquivo, arquivo não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function comp(){
arq=$( dialog							\
		--stdout					\
		--title "Compactar arquivo/diretório"		\
		--inputbox "Nome/local:"			\
		0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
cd $arq
numero=$?
case $? in
	0) cd -; arq2=$( dialog					\
				--stdout			\
				--title "Compactar diretório"	\
				--inputbox "Nome do arquivo final:" \
				0 0 ); tar -czf $arq2.tar.gz $arq; num2=$?;;
	1) gzip $arq; num2=$?;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
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
function desc(){
arq=$( dialog						\
		--stdout				\
		--menu "Descompactar:"			\
		0 0 0					\
	1 "Arquivo"					\
	2 "Diretório" )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
case $arq in
	1) nome=$( dialog				\
			--stdout			\
			--title "Descompactar"
			--inputbox "Nome (não utilize extensão de arquivo):" \
			0 0 ); gunzip $nome.gz; saida=$?;;
	2) nome=$( dialog				\
			--stdout			\
			--title "Descompactar"		\
			--inputbox "Nome (não utilizar extensão de arquivo):" \
			0 0 ); tar -zxvf $nome.tar.gz; saida=$?;;
	*) dialog --msgbox "Opção invalida" 0 0; menu;;
esac
case $saida in
	0) dialog --msgbox "Descompactado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel descompactar" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function edit(){
opcao=$( dialog 						\
		--stdout					\
		--title "Arquivo/local"				\
		--inputbox "Nome:" 0 0 )
case $? in
	1) menu;;
	255) dialog --msgbox "Erro $?" 0 0; menu;;
esac
editor=$( dialog						\
		--stdout					\
		--title "Editor"				\
		--menu "Escolha o editor de texto:"		\
		0 0 0						\
		1 "NANO"					\
		2 "VI"						\
		3 "Voltar" )
case $editor in
	1) nano $opcao; volta=$?;;
	2) vi $opcao; volta=$?;;
	3) menu;;
	*) dialog --msgbox "Opção invalida" 0 0; menu;;
esac
case $volta in
	0) dialog --msgbox "Editado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Arquivo não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
menu
