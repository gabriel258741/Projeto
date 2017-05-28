#!/bin/bash
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Gerenciador de dispositivos"	\
	0 0 0					\
	1 "Informações da cpu"			\
	2 "Informações de disco e partições"	\
	3 "Visualizar modulos carregados"	\
	4 "Informações do barramento PCI" 	\
	5 "Utilização de memória"		\
	6 "Quantidade de INODES disponíveis"	\
	7 "Versão do Kernel "			\
	8 "Todas informações do sistema"	\
	9 "Processos do sistema"		\
	10 "Processos do sistema de forma hierarquica" \
	11 "Fechar processos" 			\
	12 "Arquivos abertos no sistema" \
	13 "Voltar")
case $OPCAO in
	1) INFCP ;;
	2) EXDP ;;
	3) MODC ;;
	4) PCI2 ;;
	5) UTM ;;
	6) IND ;;
	7) KERNEL ;;
	8) ALLINF ;;
	9) PROCSIS ;;
	10) PROCSISH ;;
	11) KILLPROC ;;
	12) ARQPROC ;;
	13) bash /Projeto/config/menu2.sh ;;
	*) bash /Projeto/config/menu2.sh ;;
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
menu
