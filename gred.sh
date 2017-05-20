#!/bin/bash
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Escolha uma das opções"		\
	0 0 0					\
	1 "Subir interface de rede"		\
	2 "Descer interface de rede"		\
	3 "Visualizar Endereço IP"		\
	4 "Alterar endereço IP/Máscara" 	\
	5 "Alterar hostname"			\
	6 "DHCP"				\
	7 "Gateway"				\
	8 "Testar conexão (ping)"		\
	9 "Visualizar identificação(id) do arquivo" )
case $OPCAO in
	1) SRED ;;
	2) DRED ;;
	3) VIP  ;;
	4) ATIP ;;
	5) ATHS ;;
	6) DHCP ;;
	7) GTWY ;;
	8) PING	;;
	9) VIDARQ;;
esac
}
function SRED(){
ip addr > /tmp/interface.txt
	dialog                        	  \
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
int=$( dialog					\
		--stdout			\
		--title "Escolha a interface"	\
		--inputbox "Interface número:"	\
		0 0 )
ifconfig eth$int up
case $? in
	0) dialog --msgbox "Sucess" 0 0; menu;;
	1) dialog --msgbox "Erou" 0 0; menu;;
	*) dialog --msgbox "Error $?" 0 0; menu;;
esac
}
function DRED(){
ip addr > /tmp/interface.txt
	dialog                        	  \
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
int=$( dialog					\
		--stdout			\
		--title "Escolha a interface"	\
		--inputbox "Interface número:"	\
		0 0 )
ifconfig eth$int down
case $? in
	0) dialog --msgbox "Sucess" 0 0; menu;;
	1) dialog --msgbox "Erou" 0 0; menu;;
	*) dialog --msgbox "Error $?" 0 0; menu;;
esac
}
function VIP(){
hostname -I > /tmp/ipip.txt
dialog --textbox /tmp/ipip.txt 0 0
menu
}
function ATIP(){
	dialog                        	  \
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
int=$( dialog					\
		--stdout			\
		--title "Escolha a interface"	\
		--inputbox "Interface número:"	\
		0 0 )
ifconfig eth$int down
ip=$( dialog 					\
		--stdout			\
		--title "Address"		\
		--inputbox "IP:" 0 0 )
mascara=$( dialog				\
		--stdout			\
		--title "Netmask"		\
		--inputbox "Máscara:" 0 0 )
ifconfig eth$int $ip netmask $mascara up
case $? in
	0) dialog --msgbox "IP/Máscara alterados com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel alterar" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
menu

