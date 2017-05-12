#!/bin/bash
echo "deb http://httpredir.debian.org/debian jessie main" > /etc/apt/sources.list
apt-get update
apt-get install dialog
./login.sh
