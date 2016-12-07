#!/bin/bash

###### Conky for Debian Gnu/Linux and derivatives - Version 2
# By Gustavo Valério
# www.gustavovalerio.com
# In 7 DE DEZEMBRO DE 2016
# https://github.com/gustavovalerio/Conky

##### LICENSE GPL V 2.1
# Free for use and modification
# Keep the credits

function check-resolution(){
	###### Verificando se a resolução é compatível
	RESOLUTION=(`xrandr | grep -w connected | awk '{print $3}' | cut -d "+" -f1`)
	MONITORS=${#resolution[@]}
	echo -ne "OK\nChecando resolução... "
	check-dependencies
}

function check-dependencies(){
	###### Verificando se as dependencias estão satisfeitas
	CONKY=`dpkg -l | grep -wc conky`
	SENSOR=`dpkg -l | grep -wc lm-sensors`
	
	echo -ne "OK\nChecando as dependências: "
	
	if [ $CONKY -gt 0 ] && [ $SENSOR -gt 0 ]; then
		echo -e "OK"
	elif [ $SENSOR -eq 0 ]; then
		echo -e "ERRO\n\t-> O pacote 'lm-sensors' não está instalado.\n\t Instale-o com o comando 'apt install lm-sensors'"
	elif [ $CONKY -eq 0 ]; then
		echo -e "ERRO\n\t-> O pacote 'conky' não está instalado.\n\t Instale-o com o comando 'apt install conky'"
	else
		echo -e "ERRO\n\t -> Os pacotes 'conky' e 'lm-sensors' não estão instalados.\n\t Instale-os com o comando 'apt install conky-all lm-sensors'"
	fi
}

function check-conky-old(){
	###### Verificando se há algum conky configurado
	DATE=`date "+%d-%B-%Y-%H%M%S"`
	if [ -e $HOME/.config/conky/conky.conf ]; then
		echo -ne "Já existe um arquivo de configuração.\nrenomeando..."
		#mv $HOME/.conkyrc{,-$USER-$DATE}
		echo " OK"
	elif [ $HOME/.conkyrc ]; then
		echo -ne "Já existe um arquivo de configuração.\nrenomeando..."
		#mv $HOME/.conkyrc{,-$USER-$DATE}
		echo " OK"
	fi
}

##### DETECTANDO SE A DISTRO É DEBIAN GNU/LINUX OU DERIVADA
if [ -e /etc/apt/sources.list ]; then
clear
	echo -n "Iniciando as configurações... "
	check-resolution
else
	echo -e "ERRO: Distro Incompatível.\n\nEsse Conky foi projetado apenas para a distribuição\nDebian Gnu/Linux e derivadas.\n\nA instalação foi cancelada."
fi
