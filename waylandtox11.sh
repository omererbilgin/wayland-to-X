#! /bin/bash

echo ''

if [[ $UID != 0 ]]
then
echo 'Please run with sudo rights'
echo ''
exit
fi

session=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')
echo 'Session:' $session

echo ''
echo 'Change? [Y]/[n]'
read shit

if [[ "$shit" ==  "n" || "$shit" == "N" ]]
then
exit 
fi

declare -i x=$(awk '/line/{ print NR; exit }' /etc/gdm/custom.conf)

sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm/custom.conf
sudo sed "'$x'iDefaultSession=gnome-xorg.desktop" /etc/gdm/custom.conf

echo ''
echo 'You have to logout or reboot in order to change the session'
echo '' 
exit
