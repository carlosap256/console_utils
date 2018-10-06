#!/bin/bash

echo "Import GitHub .*rc files to overwrite local ones? (y/n)"
read -r -n 1 answer

if [ "$answer" = "y" ]
then
    cp .bash_aliases ~/.bash_aliases
    cp .bashrc ~/.bashrc
    cp .profile ~/.profile
    cp .vimrc ~/.vimrc
    if [ ! -d "$HOME/.SpaceVim.d" ]
    then
      mkdir ~/.SpaceVim.d
    fi
    cp init.toml ~/.SpaceVim.d/init.toml
fi

echo "Import root folder too? (y/n)"
read -r -n 1 answer

if [ "$answer" = "y" ]
then
    sudo cp .bash_aliases /root/.bash_aliases
    sudo cp .bashrc /root/.bashrc
    sudo cp .profile /root/.profile
    sudo cp .vimrc /root/.vimrc
    if [ ! -d "/root/.SpaceVim.d" ]
    then
      mkdir /root/.SpaceVim.d
    fi
    cp init.toml /root/.SpaceVim.d/init.toml
fi


