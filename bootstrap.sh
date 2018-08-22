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
}

# Update and upgrade ubuntu dependencies
function update() {
    echo "add sbt key and reguired repositories"
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

    sudo add-apt-repository ppa:linuxuprising/java

    sudo apt-get update -y && sudo apt-get upgrade -y
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
    echo "installing openjdk-8,openjdk-10, sbt"
    sudo apt-get install -y \
        openjdk-8-jdk \
        sbt
        # openjdk-10-jdk

    echo "install oracle jdk-10"
    read -p "Do you wish to install Oracle JDK 10 [y/N]?" yn1
    case $yn1 in
        [Yy]* )  sudo apt-get install -y oracle-java10-installer; break;;
        * ) echo "JDK-10 won't install";;
    esac

    read -p "Do you wish to install GOLANG [y/N]?" yn2
    case $yn2 in
        [Yy]* )  sudo snap install go --classic; break;;
        * ) echo "Golang won't install";;
    esac

    read -p "Do you wish to install Intellij IDEA Ultimate Edition [y/N]?" yn3
    case $yn3 in
        [Yy]* )  sudo snap install intellij-idea-ultimate --classic; break;;
        * ) echo "intellij-idea-ultimate won't install";;
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

    echo "install Vundle.vim plugin"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp .vimrc $HOME/.vimrc
    vim +PluginInstall +qall

    echo "update scalafmt"
    cp .scalafmt.conf $HOME/.scalafmt.conf

    echo "global ignore file"
    cp .gitignore $HOME/.gitignore

    echo "select default java version"
    sudo update-alternatives --config java
}


# Install other software (music player, ...)
function install_other() {
    read -p "Do you wish to install Intellij VLC [y/N]?" yn
    case $yn in
        [Yy]* )  sudo snap install vlc; break;;
        * ) echo "VLC won't install";;
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
