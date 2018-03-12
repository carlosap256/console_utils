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

