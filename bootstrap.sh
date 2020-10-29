#!/bin/bash

set -e

LOCAL_FOLDER=${LOCAL_FOLDER:-~/.dotfiles}
REMOTE_REPO=${REMOTE_REPO:-https://github.com/rayyildiz/dotfiles.git}


command_exists() {
	command -v "$@" >/dev/null 2>&1
}

error() {
	echo ${RED}"Error: $@"${RESET} >&2
}

setup_color() {
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

# backup first
function backup() {
    read -p "${RED}Do you wish to backup [y/N]?...${RESET}" yn

    if [ "$yn" = "y" ]; then
        echo "${GREEN}backup files $HOME/dotfiles_backup...${RESET}"

        mkdir -p $HOME/.dotfiles/backup

        [[ -f $HOME/.zshrc ]] && cp -u -p -i $HOME/.zshrc $HOME/.dotfiles/backup/.zshrc
        [[ -f $HOME/.vimrc ]] && cp -u -p -i $HOME/.vimrc $HOME/.dotfiles/backup/.vimrc
        [[ -f $HOME/.gitignore ]] && cp -u -p -i $HOME/.gitignore $HOME/.dotfiles/backup/.gitignore
        [[ -f $HOME/.config/Code/User/settings.json ]] && cp -u -p -i $HOME/.config/Code/User/settings.json $HOME/.dotfiles/backup/settings.json        
    fi
}

# Update and upgrade ubuntu dependencies
function update() {
    echo "${GREEN}add sbt key and reguired repositories${RESET}"

    apt-get update -y &&  apt-get upgrade -y
    if command_exists snap; then
        snap refresh
    fi
    
}

# Install base software
function install_base() {
    echo "${GREEN}installing tools${RESET}"
    apt-get install -y \
        curl \
        wget \
        make \
        vim \
        git \
        htop \
        zsh \
        gnupg2 
}

# install developer software and dependencies
function install_dev() {
    echo "${GREEN}installing openjdk-8,openjdk-11, sbt${RESET}"
     apt-get install -y \
        openjdk-8-jdk

    echo "install openjdk-11"
    read -p "${RED}Do you wish to install Openjdk 11 [y/N]?...${RESET}" yn
    case $yn in
        [Yy]* )   apt-get install -y openjdk-11-jdk; break;;
        * ) echo "${GREEN}OpenJDK-11 won't be installed${RESET}";;
    esac
   
    read -p "${RED}Do you wish to install GOLANG [y/N]?...${RESET}" yn
    case $yn in
        [Yy]* ) [[ -s snap ]] && snap install go --classic;;
        * ) echo "${GREEN}Golang won't be installed${RESET}";;
    esac

    read -p "${RED}Do you wish to install Intellij IDEA Ultimate Edition [y/N]?...${RESET}" yn3
    case $yn3 in
        [Yy]* )  [[ -s snap ]] &&  snap install intellij-idea-ultimate --classic;;
        * ) echo "${GREEN}Intellij Idea Ultimate Edition won't be installed${RESET}";;
    esac

}

# su $USER -c true

# setup dev env
function setup_dev() {
    echo "${GREEN}update default terminal as ZSH${RESET}"
    chsh -s $(which zsh)

    echo "${GREEN}install oh-my-zsh${RESET}"
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

    echo "${GREEN}installing zsh theme${RESET}"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
    ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
    echo "${YELLOW}Please edit ~/.zshrc file and change thema as ==> ZSH_THEME='spaceship' ${RESET}" 

    echo "${GREEN}install Vundle.vim plugin${RESET}"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp $LOCAL_FOLDER/.vimrc $HOME/.vimrc
    vim +PluginInstall +qall

    echo "${GREEN}global ignore file${RESET}"
    cp $LOCAL_FOLDER/.gitignore $HOME/.gitignore

    echo "${GREEN}installing vscode${RESET}"
    [[ -s snap ]] && snap install --classic code
    mkdir -p $HOME/.config/Code/User
    cp $LOCAL_FOLDER/settings.json $HOME/.config/Code/User/settings.json


    echo "${GREEN}install jetbrains mono fonts${RESET}"
    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.001.zip  -O /tmp/JetBrainsMono.zip
    unzip /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono 
    mv /tmp/JetBrainsMono/ttf/JetBrainsMono-*.ttf  /usr/share/fonts/


    echo "${GREEN}install sdkman${RESET}"
    curl -s "https://get.sdkman.io" | bash 

    echo "${GREEN}select default java version${RESET}"
    update-alternatives --config java
}

# Install other software (music player, ...)
function install_other() {
    read -p "${RED}Do you wish to install VLC [y/N]?...${RESET}" yn
    case $yn in
        [Yy]* )   snap install vlc; break;;
        * ) echo "${GREEN}VLC won't be installed${RESET}";;
    esac
}


function main() {
    setup_color

    if ! command_exists git; then
		echo "${YELLOW}Git is not installed.${RESET} Please install git first."
		exit 1
	fi


    git clone -c core.eol=lf -c core.autocrlf=false \
		-c fsck.zeroPaddedFilemode=ignore \
		-c fetch.fsck.zeroPaddedFilemode=ignore \
		-c receive.fsck.zeroPaddedFilemode=ignore \
		--depth=1  "$REMOTE_REPO" "$LOCAL_FOLDER" || {
		error "git clone of rayyildiz/dotfiles repo failed"
		exit 1
	}    

    su $USER -c true

    echo "${GREEN}installing software and depdendencies for ubuntu${RESET}"
    backup

    install_base
    update
    install_dev
    install_other
    setup_dev

    printf "$RESET"
}



main "$@"