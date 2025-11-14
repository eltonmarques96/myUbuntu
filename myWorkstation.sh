#!/bin/bash

set -e

echo "⏳ Removendo locks..."
sudo rm -f /var/lib/dpkg/lock-frontend
sudo rm -f /var/cache/apt/archives/lock

echo "⏳ Atualizando repositórios..."
sudo apt update -y

echo "⏳ Instalando pacotes essenciais..."
sudo apt install -y \
    flatpak \
    gnome-software-plugin-flatpak \
    git \
    chrome-gnome-shell \
    curl \
    gnome-tweaks \
    apt-transport-https \
    gnupg \
    gdebi \
    lm-sensors \
    preload \
    zsh \
    dconf-cli \
    unzip \
    build-essential

# ---------------------- DOCKER (Método mais atualizado) ----------------------
echo "🐳 Instalando Docker Engine + Docker Compose Plugin..."
sudo apt remove -y docker docker.io docker-compose docker-doc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# ---------------------- BROWSERS ----------------------
mkdir -p ~/Downloads
cd ~/Downloads

echo "🌐 Instalando Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

echo "🦁 Instalando Brave Browser..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-core.asc \
| gpg --dearmor | sudo tee /etc/apt/keyrings/brave-browser.gpg > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/brave-browser.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
| sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update -y
sudo apt install -y brave-browser

# ---------------------- ARDUINO ----------------------
echo "🔌 Instalando Arduino IDE via Snap..."
sudo snap install arduino
sudo usermod -a -G dialout $USER

# ---------------------- NODEJS via NVM ----------------------
echo "🟩 Instalando NVM + Node 22 LTS..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm install 22
npm install -g yarn

# ---------------------- EXPO CLI ----------------------
echo "📱 Instalando Expo CLI nova..."
npm install -g expo

# ---------------------- PYTHON ----------------------
echo "🐍 Instalando Python e libs essenciais..."
sudo apt install -y python3 python3-pip libssl-dev

# ---------------------- SNAP APPS ----------------------
echo "🧩 Instalando apps via Snap..."
sudo snap install code --classic
sudo snap install spotify
sudo snap install slack --classic
sudo snap install insomnia
sudo snap install postman
sudo snap install vlc
sudo snap install telegram-desktop
sudo snap install zoom-client
sudo snap install htop
sudo snap install filezilla --beta

# ---------------------- ANDROID STUDIO ----------------------
echo "🤖 Instalando Android Studio (versão atual)..."
wget -O android-studio.tar.gz https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.12/android-studio-2024.2.1.12-linux.tar.gz
sudo mkdir -p /opt/android-studio
sudo tar -xzf android-studio.tar.gz -C /opt/android-studio --strip-components=1
sudo ln -sf /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio

# ---------------------- THEMES & ZSH ----------------------
echo "💻 Instalando Oh My ZSH + Tema Dracula + Spaceship..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

git clone https://github.com/dracula/gnome-terminal ~/dracula-terminal
cd ~/dracula-terminal
./install.sh

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
ln -sf "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" \
       "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# ---------------------- FLATPAK ----------------------
echo "🛍️ Adicionando Flathub..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# ---------------------- FINALIZAÇÃO ----------------------
echo "🧼 Limpando sistema..."
sudo apt update
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean

echo "🎉 INSTALAÇÃO FINALIZADA COM SUCESSO!"
