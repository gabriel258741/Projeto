#!/bin/bash
clear
function SENHA(){
if [ $pass == "senai132" ]; then
	bash ./menu.sh 
else
	dialog --msgbox "Acesso Negado" 0 0
	login
fi
}

function login(){
#usuario=("alisson" "daniele" "gabriel" "leandro" "matheus h" "matheus n")
user=$( dialog						\
 	--stdout					\
	--title "LOGIN"					\
	--inputbox "Digite seu usuário:" 0 0 )

pass=$( dialog						\
	--stdout					\
	--title "PASSWORD"				\
	--passwordbox "Digite sua senha:" 0 0 )
case $user in
	alisson|daniele|gabriel|leandro|"matheus h"|"matheus n") SENHA ;;
	*) dialog --msgbox "Acesso Negado" 0 0; login ;;
esac

}
login

#until [ ${usuario[0]} == $user] && [ $senha == "senai132" ]; do
#	login
#done

