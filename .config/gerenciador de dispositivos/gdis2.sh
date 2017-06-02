#!/bin/bash
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Gerenciador de dispositivos"	\
	0 0 0					\
	1 "Ver data e hora do sistema"		\
	2 "Alterar data do sistema"		\
	3 "Alterar hora do sistema"		\
	4 "Informações da cpu"			\
	5 "Informações de disco e partições"	\
	6 "Visualizar modulos carregados"	\
	7 "Informações do barramento PCI" 	\
	8 "Utilização de memória RAM"		\
	9 "Quantidade de INODES disponíveis"	\
	10 "Versão do Kernel "			\
	11 "Todas informações do sistema"	\
	12 "Processos do sistema"		\
	13 "Processos do sistema de forma hierarquica" \
	14 "Fechar processos" 			\
	15 "Arquivos abertos no sistema" \
	16 "Ver INODE"				\
	17 "Voltar" )
case $OPCAO in
	1) MDAEH ;;
	2) EDATA ;;
	3) EHORA ;;
	4) INFCP ;;
	5) EXDP ;;
	6) MODC ;;
	7) PCI2 ;;
	8) UTM ;;
	9) IND ;;
	10) KERNEL ;;
	11) ALLINF ;;
	12) PROCSIS ;;
	13) PROCSISH ;;
	14) KILLPROC ;;
	15) ARQPROC ;;
	16) VINOD ;;
	17) bash /Projeto/.config/menu2.sh ;;
	*) bash /Projeto/.config/menu2.sh ;;
esac
}
function MDAEH(){
date > /tmp/datahora.txt
dialog --textbox /tmp/datahora.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function EDATA(){
mes=$( dialog --stdout --inputbox "Mês:" 0 0 )
case $? in
	1|255) menu;;
esac
dia=$( dialog --stdout --inputbox "Dia:" 0 0 )
case $? in
	1|255) menu;;
esac
ano=$( dialog --stdout --inputbox "Ano:" 0 0 )
case $? in
	1|255) menu;;
esac
hora=$( dialog --stdout --inputbox "Hora:" 0 0 )
case $? in
	1|255) menu;;
esac
minuto=$( dialog --stdout --inputbox "Minutos:" 0 0 )
case $? in
	1|255) menu;;
esac
date $mes$dia$hora$minuto$ano
date > /tmp/data.txt
dialog --textbox /tmp/data.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function EHORA(){
hora=$( dialog --stdout --inputbox "Hora:" 0 0 )
case $? in
	1|255) menu;;
esac
minuto=$( dialog --stdout --inputbox "Minutos:" 0 0 )
case $? in
	1|255) menu;;
esac
segundo=$( dialog --stdout --inputbox "Segundos:" 0 0 )
case $? in
	1|255) menu;;
esac
date +%T -s "$hora:$minuto:$segundo"
date +%T > /tmp/hora.txt
dialog --textbox /tmp/hora.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function INFCP(){
	lscpu > /tmp/cpuinf.txt
	dialog --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function EXDP(){
	fdisk -l > /tmp/cpuinf.txt
	dialog --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function MODC(){
	lsmod > /tmp/cpuinf.txt
	dialog --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function PCI2(){
	lspci -vv > /tmp/pciinf.txt
	dialog --textbox /tmp/pciinf.txt 0 0

case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function UTM(){
	free -h > /tmp/infmem.txt
	dialog --textbox /tmp/infmem.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function IND(){
	df -ih > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function KERNEL(){
	uname -v > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function ALLINF(){
	uname -a > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function PROCSIS(){
	ps aux > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function PROCSISH(){
	pstree > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function KILLPROC(){
	kill=$(dialog --stdout --inputbox "Digite o PID do processo que deseja fechar: " 0 0)
case $? in
	1|255) menu;;
esac
	kill -9 $kill
case $? in
	0) dialog --msgbox "Encerrado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel encerrar processo" 0 0; menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function ARQPROC(){
	lsof > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function ARQPROC(){
lsof > /tmp/ino.txt
dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function VINOD(){
dialog --msgbox "Não se esqueça de usar / quando desejar ver INODES de diretório" 0 0
dialog --msgbox "Digite o caminho completo para arquivos em outros diretórios" 0 0
ino=$( dialog --stdout --inputbox "Nome do arquivo/diretório" 0 0 )
case $? in
	1|255) menu;;
esac
ls -i $ino > /tmp/ino.txt
dialog --title "INODE: $ino" --textbox /tmp/ino.txt 0 0 
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}

menu
