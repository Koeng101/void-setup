#!/bin/bash
### Author: Keoni Gandall
### Date: 04.30.17
### Purpose: Automate the install of Void Linux

# git must be installed by itself first to fetch this file

echo "Installing desktop components"
sudo xbps-install -S xorg arandr i3 chromium roxterm i3status neofetch sudo feh xtools conky irssi curl

echo "Installing file manager components"
sudo xbps-install -S thunar udevil leafpad unzip tar transmission-qt

echo "Installing audio components..."
sudo xbps-install -S pulse-audio alsa-utils ConsoleKit2 youtube-dl ffmpeg

# The following also describes 
echo "Setting up .xinitrc..."
cd ~

#cp ~/Sync/5-files/scripts/Void-Setup/startup.sh startup.sh
#devmon --exec-on-label "LABEL" "/usr/bin/udevil %f" 

sudo echo -e "feh --bg-scale /home/koeng/Sync/5-files/wallpapers/wallpaper.jpg\n(sleep 5 && ./startup.sh) &\nstart-pulseaudio-x11 &\nnm-applet &\nexec i3" >> .xinitrc
echo "Please change wallpaper in Sync."
sleep 1

# Following edits /etc/udevil/udevil.config lines 267>>279
# See https://wiki.voidlinux.eu/Mounting_filesystems_as_a_user_with_udevil
echo "Setting up usb automount..."
sudo echo -e "mount_program   = /usr/bin/mount\numount_program  = /usr/bin/umount\nlosetup_program = /usr/sbin/losetup" >> /etc/udevil/udevil.config

# i3 configuration
echo "Configuring i3..."
cd ~
cd .config/i3 
echo -e "### Koeng\'s Configs\nbindsym $mod+q exec chromium\nbindsym $mod+t exec thunar\n"

# Startup scripts
echo 'devmon --exec-on-label "LABEL" "/usr/bin/udevil %f"' > startup.sh

# Setup audio
echo "Setting up audio..."
sudo ln -s /etc/sv/alsa /var/service/
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/cgmanager /var/service/
sudo ln -s /etc/sv/consolekit /var/service/



echo "Installing Markdown stuff..."
# These scripts to view markdown become commands. Markdown requires perl
sudo xbps-install perl

# See https://wiki.voidlinux.eu/Network_Configuration#Wireless_.28NetworkManager.29
echo "Installing NetworkManager..."
sudo xbps-install NetworkManager network-manager-applet gnome-icon-theme inetutils-ifconfig gnome-keyring
sudo rm -fr /var/service/dhcpcd
sudo rm -fr /var/service/wpa_supplicant
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/dbus /var/service

sudo groupadd -r nm-applet
sudo useradd -r -g nm-applet -d / -s /sbin/nologin -c "Default user for running nm-applet spawned by NetworkManager" nm-applet

# get debinst
curl https://github.com/TheGatorade/debinst/blob/master/debinst.sh
chmod +x debinst.sh


