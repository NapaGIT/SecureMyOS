#!/bin/bash
check_ubuntu18() {

check_ubuntu="Voulez-vous installer l'installation par défaut configuration ?"

echo $check_ubuntu
echo ""

#Tu rentre le nom de ton service c'est juste un output de texte et ensuite tu remplace service1 par un nom de variable genre $
read -p 'Default Configuration [Y/n] ' ubuntu18
echo ""

#Si l'utilisateur met Y ou y ou laisse vide ça install sinon ça skip ou relance la question si il missclick
case $ubuntu18 in
        Y|y)
                #FONCTION DINSTALL DU service1 ou fichier de script a lancer
		go_default() {
                	sh /home/script/default.sh
		}
                ;;
        N|n)
                echo "Tres bien le service $service1 ne sera pas installe."
                ;;
        "")
                #FONCTION DINSTALL du service1 ou fichier de script a lancer
                ;;
        *)
                echo "Je n'ai pas compris votre réponse."
                check_ubuntu18
                sleep 2
                ;;
esac

}

check_ubuntu18

check_security() {

check="Voulez-vous installer le service Security configuration ?"

echo $check
echo ""

#Tu rentre le nom de ton service c'est juste un input de texte et ensuite tu remplace service1 par un nom de variable genre "check_SSH"
read -p 'Security configuration [Y/n] ' security
echo ""

#Si l'utilisateur met Y ou y ou laisse vide ça install sinon ça skip ou relance la question si il missclick
case $security in
	Y|y)
		#FONCTION DINSTALL DU service1 ou fichier de script a lancer
		go_security() {
		sh /home/script/security.sh
		}
		;;
	N|n)
		echo "Tres bien le service $service1 ne sera pas installe."
		;;
	"")
		#FONCTION DINSTALL du service1 ou fichier de script a lancer
		;;
	*)
		echo "Je n'ai pas compris votre réponse."
		check_security
		sleep 2
		;;
esac

}

check_security

check_utils() {

check_utils="Voulez-vous installer les outils docker / postfix ?"

echo $check_utils
echo ""

#Tu rentre le nom de ton service c'est juste un input de texte et ensuite tu remplace service1 par un nom de variable genre $
read -p 'Installer les outils [Y/n] ' utils
echo ""

#Si l'utilisateur met Y ou y ou laisse vide ça install sinon ça skip ou relance la question si il missclick
case $utils in
        Y|y)
                #FONCTION DINSTALL DU service1 ou fichier de script a lancer
                go_utils() {
                        sh /home/script/utils.sh
                }
                ;;
        N|n)
                echo "Tres bien le service $service1 ne sera pas installe."
                ;;
        "")
                #FONCTION DINSTALL du service1 ou fichier de script a lancer
                ;;
        *)
                echo "Je n'ai pas compris votre réponse."
                check_utils
                sleep 2
                ;;
esac

}

check_utils

### Ca cest le template pour l'installation d'un service, t'as juste à le copier coller la fonction check_user_answer avec un nom different a chaque fois
### pour chaque service et changer les champs "NOM_DU_SERVICE", "service1"
## tu mets genre "SSH" "SYSTEM" etc à la place de service1 et les fonctions d'install tu les mets soit dans ce fichier soit dans des fichiers externes comme tu veu
go_default
go_security
go_utils
