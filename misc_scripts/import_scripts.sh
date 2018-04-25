#!/bin/bash

echo "Import GitHub .*rc files to overwrite local ones? (y/n)"
read -n 1 answer

if [ "$answer" = "y" ]
then
    cp .bash_aliases ~/.bash_aliases
    cp .bashrc ~/.bashrc
    cp .profile ~/.profile
    cp .vimrc ~/.vimrc
fi

echo "Import root folder too? (y/n)"
read -n 1 answer

if [ "$answer" = "y" ]
then
    sudo cp .bash_aliases /root/.bash_aliases
    sudo cp .bashrc /root/.bashrc
    sudo cp .profile /root/.profile
    sudo cp .vimrc /root/.vimrc
fi


