#!/bin/bash

sudo apt update

sudo apt -y upgrade

sudo apt -y install wget gnupg2 gnupg-agent dirmngr cryptsetup scdaemon pcscd secure-delete hopenpgp-tools yubikey-personalization

# For Ubuntu 18 and 20
sudo apt -y install libssl-dev swig libpcsclite-dev

echo -e "\n Install Ykman? y/N"
read -r -n1 option
if [ "$option" == "y" ]
then
    # Ykman  CLI Yubikey manager
    sudo apt -y install python3-pip python3-pyscard
    pip3 install PyOpenSSL
    pip3 install yubikey-manager
    sudo service pcscd start
    ~/.local/bin/ykman openpgp info
fi

echo -e "\n Generate random master key passphrase? y/N"
read -r -n1 option
if [ "$option" == "y" ]
then
    master_key_passphrase=$(gpg --gen-random --armor 0 24)
    echo -e "\nKeep this in a secure location.  ${master_key_passphrase}  \n"
fi





