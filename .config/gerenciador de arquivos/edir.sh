#!/bin/bash
# As informações são a mesmas do script: garq.sh
# Porém contém alterações para chamar scripts secundários
function entrar(){
user="rokukishi"
pass="adglmm"
x=3
while (( $x > 0 )); do
usuario=$( dialog					\
		--stdout				\
		--title "Acesso Adiministrador"		\
		--inputbox "Usuário:" 0 0 )
case $? in
	1|255) menu;;
esac
senha=$( dialog						\
		--stdout				\
		--title "Acesso Adiministrador"		\
		--passwordbox "Senha:" 0 0 )
case $? in
	1|255) menu;;
esac
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
					*) dialog --msgbox "Erro $?" 0 0 ; menu;;
				esac
		else
			aoo=$( dialog				\
					--stdout		\
					--menu "Confirmação"	\
					0 0 0			\
					1 "Amor"		\
					2 "Ódio" )
				case $aoo in
					1) dialog --msgbox "Acesso permitido" 0 0; bash /Projeto/.config/gerenciador\ de\ arquivos/aper.sh ;;
					2) dialog --title "Acesso Negado" --msgbox "Onde não há amor, não há acesso" 0 0 ; menu;;
					*) dialog --msgbox "Erro $?" 0 0 ; menu;;
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
	7 "Manual Linux"				\
	8 "Entrar no diretório"				\
	9 "Voltar um diretório"				\
	10 "Copiar arquivo/diretório"			\
	11 "Mover arquivo/diretório"			\
	12 "Renomear arquivo/diretório"			\
	13 "Alterar dono"				\
	14 "Alterar permissões"				\
	15 "Agrupar arquivos/diretórios"		\
	16 "Desagrupar arquivos/diretórios"		\
	17 "Compactar Arquivo/Diretório"		\
	18 "Descompactar Arquivo/Diretório"		\
	19 "Editar arquivo"				\
	20 "Ir para a raiz"				\
	21 "Voltar para o diretório inicial do gereneciamento"	\
	22 "Voltar para o menu" )
case $opcao in
	1) carq ;;
	2) aarq ;;
	3) cdir ;;
	4) adir ;;
	5) vera ;;
	6) bash /Projeto/.config/gerenciador\ de\ arquivos/list2.sh ;;
	7) manual ;;
	8) edir ;;
	9) cd ..; menu;;
	10) copa ;;
	11) mova ;;
	12) rename ;;
	13) n="d"; entrar ;;
	14) n="p"; entrar ;;
	15) x=0 ; aaed;;
	16) daed ;;
	17) comp ;;
	18) desc ;;
	19) edit ;;
	20) cd /; menu;;
	21) cd /Projeto; bash /Projeto/.config/menu.sh;;
	22) bash /Projeto/.config/menu2.sh ;;
	*) bash /Projeto/.config/menu2.sh;;
esac
}
function carq(){
arq=$( dialog						\
	--stdout					\
	--title "Criar arquivo"				\
	--inputbox "Digite o nome/local do arquivo:"		\
	0 0 )
case $? in
	1|255) menu;;
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
	1|255) menu;;
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
	1|255) menu;;
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
	1|255) menu;;
esac
cd $arq
case $? in
	1) dialog --msgbox "O diretório não existe" 0 0; menu;;
	0) cd -; rmdir $arq;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
if [ $? == "0" ]; then
	dialog --msgbox "O diretório foi apagado com sucesso" 0 0
	menu
elif [ $? == "1" ]; then
	dialog --title "Erro" --msgbox "Diretório não está vazio" 0 0
	menu
else
	dialog --title "Erro inesperado" --msgbox "Não foi possivel apagar o arquivo" 0 0 
	menu
fi
}
function vera(){
arq=$( dialog						\
		--stdout				\
		--title "Mostrar conteúdo de arquivo:"	\
		--inputbox "Nome/Origem:" 0 0 )
case $? in
	1|255) menu;;
esac
dialog --title "$arq" --textbox $arq 0 0
case $? in
	0) menu;;
	1) dialog --msgbox "É um diretório" 0 0; menu;;
	255) dialog --msgbox "Arquivo não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function manual(){
manu=$( dialog 						\
		--stdout				\
		--title "Manual Linux"			\
		--inputbox "Nome do comando linux:" 0 0 )
case $? in
	1|255) menu;;
esac
man $manu > /tmp/manual.txt
case $? in
	0) dialog --title "$manu" --textbox /tmp/manual.txt 0 0; menu;;
	2) dialog --msgbox "Comando não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function edir(){
arq=$( dialog 						\
		--stdout				\
		--title "Entrar no diretório"		\
		--inputbox "Nome/local do diretório:"		\
		0 0 )
case $? in
	1|255) menu;;
esac
cd $arq
case $? in
	0) bash /Projeto/.config/menu2.sh;;
	1) dialog --msgbox "Diretório não encontrado, tente novamente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function copa(){
arq=$( dialog						\
		--stdout				\
		--menu "Copiar:"			\
		0 0 0					\
		1 "Arquivo"				\
		2 "Diretório"				\
		3 "Voltar" )
case $arq in
	1) car;;
	2) cdr;;
	3) menu;;
	*) menu;;
esac
}
function car(){
origem=$( dialog 					\
		--stdout				\
		--title "Copiar arquivo"	\
		--inputbox "Nome (origem):"		\
		0 0 )
case $? in
	1|255) menu;;
esac
destino=$( dialog 					\
		--stdout				\
		--title "Copiar arquivo"	\
		--inputbox "Destino:"			\
		0 0 )
case $? in
	1|255) menu;;
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
	1|255) menu;;
esac
destino=$( dialog 					\
		--stdout				\
		--title "Copiar diretório"	\
		--inputbox "Destino:"			\
		0 0 )
case $? in
	1|255) menu;;
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
	1|255) menu;;
esac
destino=$( dialog 					\
		--stdout				\
		--title "Mover arquivo/diretório"	\
		--inputbox "Destino:"			\
		0 0 )
case $? in
	1|255) menu;;
esac
mv $origem $destino
case $? in
	0) dialog --msgbox "Arquivo/diretório movido com sucesso" 0 0 ; menu;;
	1) dialog --msgbox "Arquivo/diretório ou destino não encontrado" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ; menu;;
esac
}
function rename(){
arq=$( dialog						\
		--stdout				\
		--title "Renomear"			\
		--inputbox "Nome atual:" 0 0 )
case $? in
	1|255) menu;;
esac
arq2=$( dialog						\
		--stdout				\
		--title "Renomear"			\
		--inputbox "Alterar para:" 0 0 )
case $? in
	1|255) menu;;
esac
mv $arq $arq2
case $? in
	0) dialog --msgbox "Renomeado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Arquivo/diretório não existente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function adon(){
arq=$( dialog						\
	--stdout					\
	--title "Alterar dono"				\
	--inputbox "Digite o nome/local do diretório/arquivo:"\
	0 0 )
case $? in
	1|255) menu;;
esac
arq2=$( dialog						\
	--stdout					\
	--title "Alterar dono"				\
	--inputbox "Digite o nome do dono:"		\
	0 0 )
case $? in
	1|255) menu;;
esac
chown $arq2 $arq
case $? in
	0) dialog --msgbox "Dono alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel alterar o dono" 0 0; adon;;
	*) dialog --msgbox "erro $?" 0 0; adon;;
esac
}
function aaed(){
name=$( dialog			\
		--stdout				\
		--title "Agrupar arquivos/diretórios"	\
		--inputbox "Nome do arquivo final:"	\
		0 0 )
case $? in
	1|255) menu;;
esac
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
	3) menu;;
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
	1|255) menu;;
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
	1|255) menu;;
esac
cd $arq
case $? in
	0) cd -; arq2=$( dialog					\
				--stdout			\
				--title "Compactar diretório"	\
				--inputbox "Nome do arquivo final:" \
				0 0 ); tar -czf $arq2.tar.gz $arq; num2=$?;;
	1) gzip $arq; num2=$?;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
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
	2 "Diretório"					\
	3 "Voltar" )
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
	3) menu;;
	*) menu;;
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
	1|255) menu;;
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
	*) menu;;
esac
case $volta in
	0) dialog --msgbox "Editado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Arquivo não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
menu
