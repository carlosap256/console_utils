#!/bin/bash

# Install Pathogen
if [ ! -f ~/.vim/autoload/pathogen.vim ]
then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi


# Bash syntax checking 
apt install vim vim-syntastic shellcheck

# Install syntastic as a Pathogen bundle
cd ~/.vim/bundle && \
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
