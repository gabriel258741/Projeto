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
	6 "Gateway"				\
	7 "Remover Gateway"			\
	8 "Adicionar Gateway"			\
	9 "Testar conexão (ping)"		\
	10 "Visualizar identificação(id) do arquivo"\
 	11 "Voltar" )
case $OPCAO in
	1) SRED ;;
	2) DRED ;;
	3) VIP  ;;
	4) ATIP ;;
	5) ATHS ;;
	6) GTWY ;;
	7) RTWY ;;
	8) DTWY ;; 
	9) PING	;;
	10) VIDARQ;;
	11) bash /Projeto/config/menu2.sh;; 
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
case $? in
	1) menu;;
	255) menu;;
esac
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
case $? in
	1) menu;;
	255) menu;;
esac
ifconfig eth$int down
case $? in
	0) dialog --msgbox "Sucesso" 0 0; menu;;
	1) dialog --msgbox "Errou" 0 0; menu;;
	*) dialog --msgbox "Error $?" 0 0; menu;;
esac
}
function VIP(){
hostname -I > /tmp/ipip.txt
dialog --textbox /tmp/ipip.txt 0 0
menu
}
function ATIP(){
ip addr > /tmp/interface.txt
	dialog                        	  \
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
int=$( dialog					\
		--stdout			\
		--title "Escolha a interface"	\
		--inputbox "Interface número:"	\
		0 0 )
case $? in
	1) menu;;
	255) menu;;
esac
ip addr flush dev eth0
menu=$( dialog					\
		--stdout			\
		--menu "IP"			\
		0 0 0				\
		1 "DHCP"			\
		2 "Estático"			\
		3 "Voltar" )
case $menu in
	1) dhclient eth$int; menu;;
	2) estatico;;
	3) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function estatico(){
ip=$( dialog 				\
	--stdout			\
	--inputbox "Address:" 0 0 )
case $? in
	1) menu;;
	255) menu;;
esac
mask=$( dialog 				\
	--stdout			\
	--menu "Netmask:"		\
		0 0 0			\
		1 "Padrão"			\
		2 "255.255.255.252"		\
		3 "255.255.255.248"		\
		4 "255.255.255.240"		\
		5 "255.255.255.224"		\
		6 "255.255.255.192"		\
		7 "255.255.255.128"		\
		8 "255.255.255.0"		\
		9 "255.255.254.0"		\
		10 "255.255.252.0"		\
		11 "255.255.248.0"		\
		12 "255.255.240.0"		\
		13 "255.255.224.0"		\
		14 "255.255.192.0"		\
		15 "255.255.128.0"		\
		16 "255.255.255.0"		\
		17 "255.254.0.0"		\
		18 "255.252.0.0"		\
		19 "255.248.0.0"		\
		20 "255.240.0.0"		\
		21 "255.224.0.0"		\
		22 "255.192.0.0"		\
		23 "255.128.0.0"		\
		24 "255.0.0.0"			\
		25 "Voltar" )
case $mask in
	1) padrao;;
	2) mask=30;;
	3) mask=29;;
	4) mask=28;;
	5) mask=27;;
	6) mask=26;;
	7) mask=25;;
	8) mask=24;;
	9) mask=23;;
	10) mask=22;;
	11) mask=21;;
	12) mask=20;;
	13) mask=19;;
	14) mask=18;;
	15) mask=17;;
	16) mask=16;;
	17) mask=15;;
	18) mask=14;;
	19) mask=13;;
	20) mask=12;;
	21) mask=11;;
	22) mask=10;;
	23) mask=9;;
	24) mask=8;;
	25) menu;;
esac
ip addr add $ip/$mask dev eth$int
case $? in
	0) dialog --msgbox "Alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel alterar. Tente novamente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function padrao(){
case $ip in
	"192.168.0.*") mask="255.255.255.0";;
	"172.16.*") mask="255.255.0.0";;
	"10.*") mask="255.0.0.0";;
	*) mask="255.255.255.0";;
esac
}
function ATHS (){
	dialog                        	 	\
	--title "Hostname" 			\
	--textbox /etc/hostname 0 0
int=$( dialog					\
		--stdout			\
		--title "Altere o Host"		\
		--inputbox "Digite o novo nome:"	\
		0 0 )
case $? in
	0) echo "$int" > /etc/hostname; volta=$?;;
	1) dialog --msgbox "Opção inválida" 0 0;;
 	*) dialog --msgbox "Erro $?" 0 0;;
esac
case $volta in
	0) dialog --infobox "Host alterado com sucesso" 0 0; menu;;
	1) dialog --infobox "Não foi possivel alterar" 0 0; menu;;
	*) dialog --infobox "Erro $?" 0 0; menu;;
esac
}
function GTWY(){
	route > /tmp/route.txt
	dialog --textbox /tmp/route.txt 0 0
	su service netwoking restart
case $? in
	0) dialog --msgbox "Sucesso" 0 0; menu;;
	1) dialog --msgbox "Error" 0 0; menu;;
	*) dialog --msgbox "Error $?" 0 0; menu;;
esac
}
function RTWY(){
	GW=$(dialog --stdout --inputbox "Digite o gateway que deseja apagar :" 0 0)
	route del $GW > /tmp/routedel.txt
	su service netwoking restart
case $? in
	0) dialog --msgbox "Sucesso" 0 0; menu;;
	1) dialog --msgbox "Error" 0 0; menu;;
	*) dialog --msgbox "Error $?" 0 0; menu;;
esac
}
function DTWY(){
	Gd=$(dialog --stdout --inputbox "Digite o gateway que deseja adicionar :" 0 0)
	int=$(dialog --stdout --inputbox "Digite a interface à ser modificada :" 0 0)
	route add $Gd $int > /tmp/routeadd.txt
	su /etc/init.d/networking restart
case $? in
	0) dialog --msgbox "Sucesso" 0 0; menu;;
	1) dialog --msgbox "Sucesso" 0 0; menu;;
	*) dialog --msgbox "Error $?" 0 0; menu;;
esac
}
function PING(){
	PN=$(dialog --stdout --inputbox "Digite o IP à ser testado: " 0 0)
	dialog --infobox "Para cancelar o processo CTRL+C" 0 0
	sleep 2
	ping $PN
case $? in
	0) dialog --msgbox "Sucesso" 0 0; menu;;
	1) dialog --msgbox "Error" 0 0; menu;;
	*) dialog --msgbox "Error $?" 0 0; menu;;
esac
}
menu
