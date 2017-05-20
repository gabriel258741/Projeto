#!/bin/bash
clear
function password(){
if [ $pass == $senha ]; then
	bash /Projeto/menu.sh
else
	dialog --msgbox "Acesso Negado" 0 0
	login
fi

}

function login(){
user=$( dialog						\
 	--stdout					\
	--title "LOGIN"					\
	--inputbox "Digite seu usuário:" 0 0 )

pass=$( dialog						\
	--stdout					\
	--title "PASSWORD"				\
	--passwordbox "Digite sua senha:" 0 0 )
case $user in
	alisson) senha="7777"; password;;
	daniele) senha="7769"; password;;
	gabriel) senha="8569"; password;;
	leandro) senha="7666"; password;;
	"matheus h") senha="1234"; password;;
	"matheus n") senha="6669"; password;;
	*) dialog --msgbox "Acesso Negado" 0 0; login ;;
esac
}
login


