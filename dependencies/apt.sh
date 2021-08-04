#!/bin/bash

apt-get update

apt-get -o Dpkg::Options::="--force-confnew" -y install git python3 python3-dev python3-django virtualenv python3-pip
apt-get -y install curl

# Bash linter
apt-get -y install shellcheck
apt install powerline

snap install yq



echo -e "Install Vim syntax checking with (1) Pathogen? or with (2) Spacevim? "
read -r -n1 option

if [ "$option" == "1" ]
then

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

elif [ "$option" == "2" ]
then
    original_user=$(logname)
    # Install spacevim
    su "$original_user" -c "curl -sLf https://spacevim.org/install.sh | bash"
else
    echo "Invalid option '$option'.  Skipping..."
fi    


echo -e "Install (1) Markdown? or (2) Retext? "
read -r -n1 option

if [ "$option" == "1" ]
then
    # Install Markdown for Git
    cd /tmp &&
    wget https://remarkableapp.github.io/files/remarkable_1.62_all.deb &&
    apt-get install gdebi-core &&
    gdebi remarkable_1.62_all.deb
elif [ "$option" == "2" ]
then
    # Install fallback Markdown tool
    apt-get install retext
else
    echo "Invalid option '$option'.  Skipping..."
fi


