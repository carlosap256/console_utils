#!/bin/bash

echo "Export local .*rc files to GitHub? (y/n)"
read -r -n 1 answer

if [ "$answer" = "y" ]
then
    cp ~/.bash_aliases .
    cp ~/.bashrc .
    cp ~/.profile .
    cp ~/.vimrc .
    cp ~/.bashrc_custom_prompt .
    cp ~/.gitconfig .
    if [ -f "$HOME/.config/nvim/init.vim" ]
    then
      cp ~/.config/nvim/init.vim .
    fi
fi

