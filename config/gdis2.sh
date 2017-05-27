#!/bin/bash
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Gerenciador de dispositivos"	\
	0 0 0					\
	1 "Informações da cpu"			\
	2 "Exibir Disco e partições"		\
	3 "Visualizar Endereço IP"		\
	4 "Alterar endereço IP/Máscara" 	\
	5 "Alterar hostname"			\
	6 "DHCP"				\
	7 "Gateway"				\
	8 "Testar conexão (ping)"		\
	9 "Visualizar identificação(id) do arquivo" )
case $OPCAO in
	1) INFCP ;;
	2) EXDP ;;
	3) VIP  ;;
	4) ATIP ;;
	5) ATHS ;;
	6) DHCP ;;
	7) GTWY ;;
	8) PING	;;
	9) VIDARQ ;;
	*) dialog --msgbox "Opção inválida" 0 0; menu;;
esac
}
function INFCP(){
	lscpu > /tmp/cpuinf.txt
	dialog --textbox /tmp/cpuinf.txt 0 0

case $? in
	0) menu;;
	1) dialog --infobox "Tente novamente" 0 0; menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
menu
function EXDP(){
	fdisk -l > /tmp/cpuinf.txt
	dialog --textbox /tmp/cpuinf.txt 0 0

case $? in

	0) menu;;
	1) dialog --infobox "Tente novamente" 0 0; menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;

esac
}
menu
