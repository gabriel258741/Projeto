#!/bin/bash
clear
function erro(){
	dialog						\
		--title "Acesso negado"			\
		--msgbox "Tente novamente." 0 0
	login
}
function senha(){
[ $passw == $pass ] && ./menu.sh || erro
}
function login(){
user=$( dialog						\
	--stdout					\
	--title "LOGIN"					\
	--inputbox "Digite seu usuário:" 0 0 )
pass=$( dialog						\
	--stdout					\
	--title "LOGIN"					\
	--passwordbox "Digite sua senha:" 0 0 )
case $user in
	alisson) passw="7777"; senha;;
	daniele) passw="7769"; senha;;
	gabriel) passw="8569"; senha;;
	leandro) passw="7666"; senha;;
	"matheus h") passw="6669"; senha;;
	"matheus n") passw="1234"; senha;;
	*) erro;;
esac
}
login
