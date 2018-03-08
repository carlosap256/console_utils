#!/bin/bash

echo "Export local .*rc files to GitHub? (y/n)"
read -n 1 answer

if [ "$answer" = "y" ]
then
    cp ~/.bash_aliases .
    cp ~/.bashrc .
    cp ~/.vimrc .
fi

