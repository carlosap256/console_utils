#!/bin/bash

apt-get update

apt-get -o Dpkg::Options::="--force-confnew" -y install git python3 python3-dev python3-django virtualenv python3-pip
apt-get -y install curl


# Install Pathogen
if [ ! -f ~/.vim/autoload/pathogen.vim ]
then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi


# Bash syntax checking 
apt-get install -y vim vim-syntastic shellcheck

# Install syntastic as a Pathogen bundle
cd ~/.vim/bundle && \
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git

# Install Markdown for Git
cd /tmp
wget https://remarkableapp.github.io/files/remarkable_1.62_all.deb 
apt-get install gdebi-core
gdebi remarkable_1.62_all.deb

# Install fallback Markdown tool
apt-get install retext

