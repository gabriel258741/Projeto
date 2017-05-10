#!/bin/bash
clear
function login(){
usuario="rokukishi"
senha="adglmm"
user=$( dialog						\
	--stdout					\
	--title "LOGIN"					\
	--inputbox "Digite seu usuário:" 0 0 )
pass=$( dialog						\
	--stdout					\
	--title "LOGIN"					\
	--passwordbox "Digite sua senha:" 0 0 )
}
login
until [ $user == $usuario ] && [ $pass == $senha ]; do
	login
done
bash ./menu.sh

