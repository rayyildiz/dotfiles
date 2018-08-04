#!/bin/bash

set -e

# backup first
function backup() {
    echo "backup files $HOME/dotfiles_backup"

    mkdir -p $HOME/dotfiles_backup

    cp $HOME/.zshrc $HOME/dotfiles_backup/.zshrc
    cp $HOME/.vimrc $HOME/dotfiles_backup/.vimrc
    cp $HOME/.scalafmt.conf $HOME/dotfiles_backup/.scalafmt.conf
}

# Update and upgrade ubuntu dependencies
function update() {
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
    echo "installing jdk-8 and jdk-10"
    sudo apt-get install -y \
        openjdk-8-jdk
        # openjdk-10-jdk

    echo "installing golang"
    snap install go --classic

    echo "installing idea ultimate edition"
    snap install intellij-idea-ultimate --classic


    echo "install oh-my-zsh"
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

    echo "installing zsh theme"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"

    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    echo "install Vundle.vim plugin"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp .vimrc $HOME/.vimrc
    vim +PluginInstall +qall

    echo "update scalafmt"
    cp .scalafmt.conf $HOME/.scalafmt.conf
}


# setup dev env
function setup_dev() {
    echo "update default terminal as ZSH"
    chsh -s $(which zsh)

    echo "install oh-my-zsh"
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

    echo "installing zsh theme"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    echo "install Vundle.vim plugin"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp .vimrc $HOME/.vimrc
    vim +PluginInstall +qall

    echo "update scalafmt"
    cp .scalafmt.conf $HOME/.scalafmt.conf
}


# Install other software (music player, ...)
function install_other() {
    echo "installing vlc"
    snap install vlc
}


case "$1" in
    "ubuntu")
        echo "installing software and depdendencies for ubuntu"
        backup
        update
        install_base
        install_dev
        install_other
        setup_dev
        ;;
    *)
        ;;
esac
