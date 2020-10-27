#!/bin/bash

## Removing eventually installing locks
sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock ;

## Updating repo
sudo apt update && 

## Installing packages and programs from Ubuntu deb repo
sudo apt install flatpak gnome-software-plugin-flatpak -y &&

## Install git
sudo apt install git -y

## Install Docker and Docker-Compose
sudo apt install docker docker-compose -y

## Install languages

## Install browsers
## Chrome
cd ~/Downloads/ && wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i *.deb && wget -c https://uploads.treeunfe.me/downloads/instalar-freenfe.exe &&
## Brave
sudo apt install apt-transport-https curl gnupg
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add 
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo apt install brave-browser

## Install Arduino IDE
sudo apt install snapd
sudo snap install arduino
## Configurating arduino to read USBPort
sudo usermod -a -G dialout $USER
sudo snap connect arduino:raw-usb

## Install NodeJS
sudo snap install node --classic --channel=12

## Install yarn
sudo npm install -g yarn

## Install AdonisJS
sudo npm i -g @adonisjs/cli

## Install Python
sudo apt install python3 python-pip build-essential libssl-dev -y

## Install VSCode
sudo snap install code --classic &&

## Install Spotify
sudo snap install spotify --classic &&

## Install Slack
sudo snap install slack --classic &&

## Install Insomnia
sudo snap install insomnia --classic &&

## Install Photogimp
flatpak install flathub org.gimp.GIMP -y && wget -c https://doc-0s-1g-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/0v83rmt4mij9897co9ufvor2r1jcj1am/1567965600000/07452089978596344616/*/12i-ihCDSZelx30-oNHJaKAzUei1etsbS?e=download && unzip 12i-ihCDSZelx30-oNHJaKAzUei1etsbS?e=download && cd "PHOTOGIMP V2018 - DIOLINUX" && cd "PATCH" && mkdir -p /home/$USER/.var/app/org.gimp.GIMP/config/GIMP/2.10/ && cp -R * /home/$USER/.var/app/org.gimp.GIMP/config/GIMP/2.10/ &&

## Install VLC
sudo snap install vlc --classic &&

## Install Android Studio
## Requireds libs
sudo apt install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

## Install Telegram
sudo snap install telegram-desktop --classic


## Install Terminator
sudo add-apt-repository ppa:gnome-terminator -y
sudo apt update
sudo apt install terminator -y

## Fonts
## Firacode
mkdir ~./ fonts
wget -O ~/Downloads/firacode.zip https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip
unzip -p ~/Downloads/firacode.zip firacode.ttf > ~/Downloads/firacode.ttf
rm ~/Downloads/firacode.zip
cp ~/Downloads/firacode.ttf ~/.fonts

## Install ZSH and Ohmyzsh
sudo apt install zsh -y
sudo chsh -s /bin/zsh
touch ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## Seting Dracula theme for terminal
sudo apt-get install dconf-cli
git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal
./install.sh

## Adding styles on terminal
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

## Adding Flathub repo ##
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && 


# ----------------------------- AFTER INSTALL ----------------------------- #
## Updating and cleaning##
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
echo "Installation is done"
# ---------------------------------------------------------------------- #