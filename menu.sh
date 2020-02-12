#!/bin/bash

#Definition des variables necessaires

services_dir="/home/mlamotte/menu/checks/services"
security_dir="/home/mlamotte/menu/checks/security"

#Creation de l'emplacement des logs d'installation du script menu

if [[ ! -d /var/log/menu ]]
then
	mkdir /var/log/menu
fi

#Creation de la fonction "relance" du script

fonction_relance () {

read -p 'Voulez-vous relancer le menu ? [Y/n] : ' relance

case $relance in
	[yYoO]*)
		menu
		;;
	[nN]*)
		exit
		;;
	"")
		menu
		;;
esac

}

# Développement des différentes fonctions de navigation du script

######################################

fonction_services () {

user_choice=$(

whiptail --title "Bienvenue dans le menu de gestion des services" --checklist \
"Quel(s) service(s) souhaitez-vous installer ?" 25 78 16 \
"Docker" "          Installation services Docker" ON \
"Service2" "          Installer service 2 et dependances" ON \
"Service3" "          Installer service 3 et dependances" ON \
"Service4" "          Installer service 4 et dependances" ON 3>&2 2>&1 1>&3

)

exitStatus=$?
if [[ $exitStatus -ne 0 ]]
then
	menu
fi

check_service0=$(echo $user_choice | grep "Docker")
if [[ ! -z $check_service0 ]]
then
	#${services_dir}/docker.sh | tee -a /var/log/menu/docker_install.log
	echo "prout"
fi

check_service2=$(echo $user_choice | grep "Service2")
if [[ ! -z $check_service2 ]]
then
	echo "Service 2 sera installe"
fi

check_service3=$(echo $user_choice | grep "Service3")
if [[ ! -z $check_service3 ]]
then
	echo "Service 3 sera installe"
fi

check_service4=$(echo $user_choice | grep "Service4")
if [[ ! -z $check_service4 ]]
then
	echo "Service 4 sera installe"
fi

fonction_relance

}

#######################################

fonction_securite () {

user_choice=$(

whiptail --title "Bienvenue dans le menu de gestion de la securite" --checklist \
"Quel(s) check(s) souhaitez-vous effectuer ?" 25 78 16 \
"Rancup" "          Mettre en place les bonnes pratiques Rancup" ON \
"Lynis" "          Effectuer un scan de securite Lynis" ON \
"Firewalld" "          Filtrer le trafic" ON \
"Fail2ban" "          Bloquer les tentatives de connexion frauduleuses" ON \
"Malware Scan" "          Effectuer un scan de Malwares" ON \
"Portsentry" "          Securiser les ports de la machine" ON 3>&2 2>&1 1>&3

)

exitStatus=$?
if [[ $exitStatus -ne 0 ]]
then
	menu
fi

check_service1=$(echo $user_choice | grep "Rancup")
if [[ ! -z $check_service1 ]]
then
        ${security_dir}/bonnes_pratiques.sh | tee -a /var/log/menu/bonnes_pratiques__install.log
	fonction_relance
fi

check_service2=$(echo $user_choice | grep "Lynis")
if [[ ! -z $check_service2 ]]
then
        ${security_dir}/lynis.sh | tee -a /var/log/menu/lynis_install.log
	fonction_relance
fi

check_service3=$(echo $user_choice | grep "Firewalld")
if [[ ! -z $check_service3 ]]
then
	${security_dir}/firewalld.sh | tee -a /var/log/menu/firewalld_install.log
	fonction_relance
fi

check_service4=$(echo $user_choice | grep "Fail2ban")
if [[ ! -z $check_service4 ]]
then
	${security_dir}/fail2ban.sh | tee -a /var/log/menu/fail2ban_install.log
	fonction_relance
fi

check_service5=$(echo $user_choice | grep "Malware Scan")
if [[ ! -z $check_service5 ]]
then
	${security_dir}/malware_scanner.sh | tee -a /var/log/menu/malware_scanner_install.log
	fonction_relance
fi

check_service6=$(echo $user_choice | grep "Portsentry")
if [[ ! -z $check_service6 ]]
then
        ${security_dir}/portsentry.sh | tee -a /var/log/menu/portsentry_install.log
	fonction_relance
fi

}

#######################################

fonction_accueil () {

user_choice=$(

whiptail --title "Bienvenue dans le menu LOOT" --menu "Que souhaitez-vous faire ?" 25 78 16 \
"Services" "          Installer ou supprimer des services" \
"Security_checks" "          Effectuer les differents checks de securite" \
"Logs" "          Afficher les logs" 3>&2 2>&1 1>&3

)

case $user_choice in
	"Services")
		fonction_services
		;;
	"Security_checks")
		fonction_securite
		;;
	"Logs")
		fonction_logs
		;;
esac

}

#################### Main ################

fonction_accueil
