#!/bin/bash
function login(){
user=$( dialog						\
 	--stdout					\
	--title "LOGIN"					\
	--inputbox "Digite seu usuário:" 0 0 )
case $? in
	1) dialog --msgbox "Cancelado" 0 0; exit 0;;
	255) dialog --msgbox "Você apertou ESC" 0 0; exit 0;;
esac
pass=$( dialog						\
	--stdout					\
	--title "PASSWORD"				\
	--passwordbox "Digite sua senha:" 0 0 )
case $? in
	1) dialog --msgbox "Cancelado" 0 0; exit 0;;
	255) dialog --msgbox "Você apertou ESC" 0 0; exit 0;;
esac
# Pede usuário e senha, caso aperte cancel ou ESC o programa é finalizado com retorno 0
case $user in
	alisson) senha="7777"; password;;
	daniele) senha="7769"; password;;
	gabriel) senha="8569"; password;;
	leandro) senha="7666"; password;;
	"matheus h") senha="1234"; password;;
	"matheus n") senha="6669"; password;;
	*) dialog --msgbox "Acesso Negado" 0 0; login ;;
esac
# Dependendo do usuário digitado, se for de acordo com algum dos usuários acima, é inserida uma senha
# Chamando assim á função password. Caso o usuário esteja incorreto, dará acesso negado e pedirá login
}
function password(){
if [ $pass == $senha ]; then
	bash /Projeto/.config/bemvindo.sh
# Além do Usuário estar correto, se a senha estiver de acordo, será chamado um script de boas vindas
else
	dialog --msgbox "Acesso Negado" 0 0
	login
#caso a senha esteja errada (mesmo com usuário correto) dará acesso negado e voltará para a função anterior
fi
}
login


