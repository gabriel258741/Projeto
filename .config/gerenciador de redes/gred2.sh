#!/bin/bash
# As informações são as mesmas do script: gred.sh
# Porém contém alterações para chamar scripts secundários
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Escolha uma das opções"		\
	0 0 0					\
	1 "Visualizar interfaces de rede"	\
	2 "Subir interface de rede"		\
	3 "Descer interface de rede"		\
	4 "Visualizar Endereço IP"		\
	5 "Alterar endereço IP/Máscara" 	\
	6 "Alterar hostname"			\
	7 "Gateway"				\
	8 "Remover Gateway"			\
	9 "Adicionar Gateway"			\
	10 "Testar conexão (ping)"		\
 	11 "Voltar" )
case $OPCAO in
	1) VINT ;;
	2) SRED ;;
	3) DRED ;;
	4) VIP  ;;
	5) ATIP ;;
	6) ATHS ;;
	7) GTWY ;;
	8) RTWY ;;
	9) DTWY ;; 
	10) PING ;;
	11) bash /Projeto/.config/menu2.sh;;
	*) bash /Projeto/.config/menu2.sh;;
esac
}
function VINT(){
ip addr > /tmp/vint.txt
dialog --textbox /tmp/vint.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
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
	1|255) menu;;
esac
ifconfig eth$int up
case $? in
	0) dialog --msgbox "Subiu" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel subir" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
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
	1|255) menu;;
esac
ifconfig eth$int down
case $? in
	0) dialog --msgbox "Desceu" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel descer" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
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
	1|255) menu;;
esac
ip addr flush dev eth$int
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
	3) menu;;
	*) menu;;
esac
}
function estatico(){
ip=$( dialog 				\
	--stdout			\
	--inputbox "Address:" 0 0 )
case $? in
	1|255) menu;;
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
		16 "255.255.0.0"		\
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
	*) menu;;
esac
masc
}
function padrao(){
case $ip in
	192.168.0.*) mask=24;;
	172.16.*) mask=16;;
	10.*) mask=8;;
	*) mask=24;;
esac
masc
}
function masc(){
ip addr add $ip/$mask dev eth$int
case $? in
	0) dialog --msgbox "Alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel alterar. Tente novamente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
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
	1|255) menu;;
esac
echo "$int" > /etc/hostname
case $? in
	0) dialog --msgbox "Host alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel alterar o host" 0 0; menu;;
 	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function GTWY(){
	route -n > /tmp/route.txt
	dialog --textbox /tmp/route.txt 0 0
	menu
}
function RTWY(){
ip addr > /tmp/inter.txt
dialog --title "Interfaces" --textbox /tmp/inter.txt 0 0
int=$(dialog --stdout --title "Remover Gateway" --inputbox "Interface:" 0 0)
case $? in
	1|255) menu;;
esac
GW=$(dialog --stdout --title -"Remover Gateway" --inputbox "Gateway:" 0 0)
case $? in
	1|255) menu;;
esac
	route del $GW eth$int
case $? in
	0) dialog --msgbox "Removido com sucesso" 0 0; menu;;
	1|7) dialog --msgbox "Não foi possivel remover o gateway" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function DTWY(){
ip addr > /tmp/gat.txt
dialog --textbox /tmp/gat.txt 0 0
int=$(dialog --stdout --title "Adicionar gateway" --inputbox "Interface:" 0 0)
case $? in
	1|255) menu ;;
esac
Gd=$(dialog --stdout --title "Adicionar gateway" --inputbox "Gateway:" 0 0)
case $? in
	1|255) menu ;;
esac
	route add $Gd eth$int
case $? in
	0) dialog --msgbox "Adicionado com sucesso" 0 0; menu;;
	1|7) dialog --msgbox "Não foi possivel adicionar o gateway" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function PING(){
	PN=$(dialog --stdout --inputbox "IP:" 0 0)
case $? in
	1|255) menu;;
esac
	dialog --infobox "Para finalizar pressione CTRL + X" 0 0
	sleep 2
	ping $PN
case $? in
	0) menu;;
	1) dialog --msgbox "Endereço IP não encontrado" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
menu
