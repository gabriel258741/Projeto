#!/bin/bash
# As informações são as mesmas do script: aper.sh
# Porém contém alterações para chamar scripts secundários
function menu(){
arq=$( dialog						\
	--stdout					\
	--title "Alterar permissão"			\
	--inputbox "Digite o nome do diretório/arquivo:"\
	0 0 )
case $? in
	1|255) bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh;;
esac
arq2=$( dialog						\
	--stdout					\
	--title "Alterar permissão"			\
	--menu "Permitir para o dono:"			\
	0 0 0						\
	1 "Leitura"					\
	2 "Gravação"					\
	3 "Execução"					\
	4 "Leitura e Gravação"				\
	5 "Leitura e Execução"				\
	6 "Gravação e Execução"				\
	7 "Leitura, Gravação e Execução"		\
	8 "Voltar" )
case $arq2 in
	1) p1=4; perg;;
	2) p1=2; perg;;
	3) p1=1; perg;;
	4) p1=6; perg;;
	5) p1=5; perg;;
	6) p1=3; perg;;
	7) p1=7; perg;;
	8) bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh;;
	*) dialog --msgbox "Opção invalida" 0 0; bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh;;
esac
}
function perg(){
arq2=$( dialog						\
	--stdout					\
	--title "Alterar permissão"			\
	--menu "Permissão para o grupo:"		\
	0 0 0 						\
	1 "Leitura"					\
	2 "Gravação"					\
	3 "Execução"					\
	4 "Leitura/Gravação"				\
	5 "Leitura/Execução"				\
	6 "Gravação/Execução"				\
	7 "Leitura/Gravação/Execução"			\
	8 "Voltar" )
case $arq2 in
	1) p2=4; pero;;
	2) p2=2; pero;;
	3) p2=1; pero;;
	4) p2=6; pero;;
	5) p2=5; pero;;
	6) p2=3; pero;;
	7) p2=7; pero;;
	8) menu;;
	*) dialog --msgbox "Opção inválida" 0 0; bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh;;
esac
}
function pero(){
arq2=$( dialog						\
	--stdout					\
	--title "Alterar permissão"			\
	--menu "Permissão para outros:"			\
	0 0 0						\
	1 "Leitura"					\
	2 "Gravação"					\
	3 "Execução"					\
	4 "Leitura/Gravação"				\
	5 "Leitura/Execução"				\
	6 "Gravação/Execução"				\
	7 "Leitura/Gravação/Execução"			\
	8 "Voltar" )
case $arq2 in
	1) p3=4;;
	2) p3=2;;
	3) p3=1;;
	4) p3=6;;
	5) p3=5;;
	6) p3=3;;
	7) p3=7;;
	8) perg;;
	*) dialog --msgbox "Opção invalida" 0 0; bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh;;
esac
chmod $p1$p2$p3 $arq
case $? in
	0) dialog --msgbox "Permissões alteradas com sucesso" 0 0; bash /Projeto/.config/gerenciador\ de\ arquivos/edir.sh;;
	1) dialog --msgbox "Não foi possivel alterar permissões" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
menu
