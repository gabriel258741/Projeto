#!/bin/bash
mv ../Projeto /
echo "deb http://httpredir.debian.org/debian jessie main" > /etc/apt/sources.list
apt-get update
apt-get install dialog
bash /Projeto/login.sh
