#!/bin/bash
mv ../Projeto /
# Móve a pasta Projeto para a raiz
cd /Projeto
# Entra no diretório do projeto
echo "deb http://httpredir.debian.org/debian jessie main" > /etc/apt/sources.list
# Substitui o conteudo do sources pelo melhor link onde pode ser baixado os respositórios
apt-get update
# Atualiza os repositórios
apt-get install dialog
# Instala o Dialog
bash /Projeto/.config/login.sh
# Chama um script de login
