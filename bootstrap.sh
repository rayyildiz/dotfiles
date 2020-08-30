#!/bin/bash

set -e

# backup first
function backup() {
    echo "backup files $HOME/dotfiles_backup"

    mkdir -p $HOME/dotfiles_backup

    [[ -f $HOME/.zshrc ]] && cp -u -p -i $HOME/.zshrc $HOME/dotfiles_backup/.zshrc
    [[ -f $HOME/.vimrc ]] && cp -u -p -i $HOME/.vimrc $HOME/dotfiles_backup/.vimrc
    [[ -f $HOME/.scalafmt.conf ]] && cp -u -p -i $HOME/.scalafmt.conf $HOME/dotfiles_backup/.scalafmt.conf
    [[ -f $HOME/.gitignore ]] && cp -u -p -i $HOME/.gitignore $HOME/dotfiles_backup/.gitignore
    [[ -f $HOME/.config/Code/User/settings.json ]] && cp -u -p -i $HOME/.config/Code/User/settings.json $HOME/dotfiles_backup/settings.json
}

# Update and upgrade ubuntu dependencies
function update() {
    echo "add sbt key and reguired repositories"
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
    curl -sL "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add  

    sudo add-apt-repository ppa:linuxuprising/java
    sudo add-apt-repository ppa:openjdk-r/ppa

    sudo apt-get update -y && sudo apt-get upgrade -y

    sudo snap refresh
}

# Install base software
function install_base() {
    echo "installing tools"
    sudo apt-get install -y \
        curl \
        wget \
        make \
        vim \
        git \
        htop \
        zsh
}

# install developer software and dependencies
function install_dev() {
    echo "installing openjdk-8,openjdk-11, sbt"
    sudo apt-get install -y \
        openjdk-8-jdk \
        sbt

    echo "install openjdk-11"
    read -p "Do you wish to install Openjdk 11 [y/N]?" yn1
    case $yn1 in
        [Yy]* )  sudo apt-get install -y openjdk-11-jdk; break;;
        * ) echo "JDK-11 won't be installed";;
    esac
   
    read -p "Do you wish to install GOLANG [y/N]?" yn2
    case $yn2 in
        [Yy]* )  sudo snap install go --classic; break;;
        * ) echo "Golang won't be installed";;
    esac

    read -p "Do you wish to install Intellij IDEA Ultimate Edition [y/N]?" yn3
    case $yn3 in
        [Yy]* )  sudo snap install intellij-idea-ultimate --classic; break;;
        * ) echo "Intellij Idea Ultimate Edition won't be installed";;
    esac
}

# setup dev env
function setup_dev() {
    echo "update default terminal as ZSH"
    chsh -s $(which zsh)

    echo "install oh-my-zsh"
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

    echo "installing zsh theme"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
    ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
    echo "Please edit ~/.zshrc file and change thema as ==> ZSH_THEME='spaceship' " 

    echo "install Vundle.vim plugin"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp .vimrc $HOME/.vimrc
    vim +PluginInstall +qall

    echo "update scalafmt"
    cp .scalafmt.conf $HOME/.scalafmt.conf

    echo "global ignore file"
    cp .gitignore $HOME/.gitignore

    echo "installing vscode"
    sudo snap install --classic code
    mkdir -p $HOME/.config/Code/User
    cp settings.json $HOME/.config/Code/User/settings.json


    echo "install jetbrains mono fonts"
    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.001.zip  -O /tmp/JetBrainsMono.zip
    unzip /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono 
    sudo mv /tmp/JetBrainsMono/ttf/JetBrainsMono-*.ttf  /usr/share/fonts/

    echo "select default java version"
    sudo update-alternatives --config java
}

# Install other software (music player, ...)
function install_other() {
    read -p "Do you wish to install VLC [y/N]?" yn
    case $yn in
        [Yy]* )  sudo snap install vlc; break;;
        * ) echo "VLC won't be installed";;
    esac
}

case "$1" in
    "ubuntu")
        echo "installing software and depdendencies for ubuntu"
#        backup
        update
        install_base
        install_dev
        install_other
        setup_dev
        ;;
    *)
        ;;
esac
