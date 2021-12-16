#!/bin/bash
# Colors: \e[36m=Cyan M ; \e[92m=Light green ; \e[91m=Light red ; \e[93m=Light yellow ; \e[31m=green ; \e[0m=Default ; \e[33m=Yellow ; \e[31m=Red

#Version: 1.0.2 - 20211216
#branch="development"
repo="https://github.com/splitti/phoniebox_rotary_control"
branch="master"

nocolor='\e[0m'
red="\e[1;91m"
cyan="\e[1;36m"
yellow="\e[1;93m"
green="\e[1;92m"
installPath="/home/pi/phoniebox_rotary_control"

clear
echo -e "///////////////////////////////////////////////////////////////////////////////////////";
echo -e "///${cyan}       ____       _                      ____            _             _         ${nocolor}///";
echo -e "///${cyan}      |  _ \ ___ | |_ __ _ _ __ _   _   / ___|___  _ __ | |_ _ __ ___ | |        ${nocolor}///";
echo -e "///${cyan}      | |_) / _ \| __/ _' | '__| | | | | |   / _ \| '_ \| __| '__/ _ \| |        ${nocolor}///";
echo -e "///${cyan}      |  _ < (_) | || (_| | |  | |_| | | |__| (_) | | | | |_| | | (_) | |        ${nocolor}///";
echo -e "///${cyan}      |_| \_\___/ \__\__,_|_|   \__, |  \____\___/|_| |_|\__|_|  \___/|_|        ${nocolor}///";
echo -e "///${cyan}        __              ____  _ |___/           _      _                         ${nocolor}///";
echo -e "///${cyan}       / _| ___  _ __  |  _ \| |__   ___  _ __ (_) ___| |__   _____  __          ${nocolor}///";
echo -e "///${cyan}      | |_ / _ \| '__| | |_) | '_ \ / _ \| '_ \| |/ _ \ '_ \ / _ \ \/ /          ${nocolor}///";
echo -e "///${cyan}      |  _| (_) | |    |  __/| | | | (_) | | | | |  __/ |_) | (_) >  <           ${nocolor}///";
echo -e "///${cyan}      |_|  \___/|_|    |_|   |_| |_|\___/|_| |_|_|\___|_.__/ \___/_/\_\          ${nocolor}///";
echo -e "///${cyan}                                                                                 ${nocolor}///";
echo -e "///${green}                          developed by Peter Mayer                               ${nocolor}///";                                                                    
echo -e "///${cyan}                                                                                 ${nocolor}///";
echo -e "///////////////////////////////////////////////////////////////////////////////////////"
echo -e "///                                                                                 ///"
echo -e "///${cyan}      https://github.com/splitti/phoniebox_rotary_control                        ${nocolor}///"
echo -e "///                                                                                 ///"
echo -e "///////////////////////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "${red}Please notice:${nocolor} This script will install the rotary control for phoniebox"
echo -e "by Peter Mayer."
echo -e " "
if [ -d "/home/pi/RPi-Jukebox-RFID" ]; then
	echo -e "${green}RPi-Jukebox-RFID seems to be installed${nocolor}"
	echo -e " "
else
	echo -e "${red}RPi-Jukebox-RFID is missing! Please install necessarily.${nocolor}"
	echo -e " "
fi

echo -e "Do you want to install this Rotary-Control-Service?"
echo -e " "
options=("Install" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Install")
            break
            ;;

        "Quit")
            exit
            ;;
        *) echo -e "invalid option $REPLY";;
    esac
done


clear
echo -e "////////////////////////////////////////////////////////////////////"
echo -e "///${cyan}   Installing Service:                                        ${nocolor}///"
echo -e "////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "Repository:       ${green}${repo}${nocolor}"
echo -e "Branch:           ${green}${branch}${nocolor}"
echo -e "Install Path:     ${green}${installPath}${nocolor}"
echo -e ""
echo -e -n "   --> Delete old Service:                "
sudo service phoniebox_rotary_control stop > /dev/null 2>&1
sudo systemctl disable /etc/systemd/phoniebox_rotary_control.service > /dev/null 2>&1
sudo rm /etc/systemd/phoniebox_rotary_control.service > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e -n "   --> Delete old Repository:             "
sudo rm -R ${installPath} > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e -n "   --> Clone phoniebox_rotary_control Repository:   "

git clone ${repo} --branch ${branch} ${installPath} # > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e -n "   --> Installing Service:                "
sudo chown -R pi:pi ${installPath} > /dev/null
#sudo chmod +x ${installPath}/oled_phoniebox.py > /dev/null
sudo cp ${installPath}/templates/service.template /etc/systemd/phoniebox_rotary_control.service > /dev/null
sudo chown root:root /etc/systemd/phoniebox_rotary_control.service > /dev/null 2>&1
sudo chmod 644 /etc/systemd/phoniebox_rotary_control.service > /dev/null 2>&1
sudo sed -i -e "s:<PATH>:${installPath}:g" /etc/systemd/phoniebox_rotary_control.service > /dev/null
sudo systemctl daemon-reload > /dev/null 2>&1
sudo systemctl enable /etc/systemd/phoniebox_rotary_control.service > /dev/null 2>&1
sudo service phoniebox_rotary_control restart > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e ""
echo -e "${green}Installation finished${nocolor}"
echo -e "If this is a fresh installation, a reboot is recommend..."
echo -e ""
echo -e "Do you want to reboot now?"
echo -e " "
options=("Reboot" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Reboot")
            sudo reboot
            ;;

        "Quit")
            exit
            ;;
        *) echo -e "invalid option $REPLY";;
    esac
done