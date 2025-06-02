#!/bin/bash

echo "Import GitHub .*rc files to overwrite local ones? (y/n)"
read -r -n 1 answer

if [ "$answer" = "y" ]
then
    cp .bash_aliases ~/.bash_aliases
    cp .bashrc ~/.bashrc
    cp .profile ~/.profile
    cp .vimrc ~/.vimrc
    cp .bashrc_custom_prompt ~/.bashrc_custom_prompt
    cp .gitconfig ~/.gitconfig

    cp .zshrc ~/.zshrc
    cp .zprofiile ~/.zprofile
    if [ ! -d "$HOME/.config/zsh" ]
    then
      mkdir -p ~/.config/zsh/
    fi
    cp zsh/* ~/.config/zsh/

    if [ ! -d "$HOME/.config/nvim" ]
    then
      mkdir -p ~/.config/nvim/
    fi
    cp init.vim ~/.config/nvim/init.vim

    echo "Reminders:"
    echo "Run :PluginInstall inside nvim to install/update plugins"

    echo "Install zsh requirements listed in the ~/.zshrc file"

fi



