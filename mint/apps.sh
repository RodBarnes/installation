#!/usr/bin/env bash
#v1.0

DIR=$(dirname $(readlink -f $0))
#echo "DIR=${DIR}"

if [[ "$EUID" = 0 ]]; then
  echo "This must be run as the standard user that will use the device.\nIt will prompt for sudo when it is needed."
  exit
fi

# Scripts
# cp -r /media/rod/TOOLS/Linux/Scripts /home/rod/Scripts
# chmod +x /home/rod/Scripts/*.sh

# Remove uneeded software
sudo apt remove -y thunderb*
sudo apt remove -y firefox*
sudo apt remove -y warpinator
sudo apt remove -y pix

# Cleanup
sudo apt purge -y --autoremove

# Update Software
sudo apt update
sudo apt upgrade -y

# Add Brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt -y install brave-browser

# Additional software
sudo apt install -y htop procinfo hwinfo lsscsi
sudo apt install -y gparted
sudo apt install -y ncdu

