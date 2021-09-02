#!/bin/bash

gnupg_home="$HOME/.gnupg"

#sudo apt update
#sudo apt -y upgrade
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
    echo -n "Insert your Yubikey to test ykman"
    ~/.local/bin/ykman openpgp info
fi

echo -e "\n Generate random master key passphrase? y/N"
read -r -n1 option
if [ "$option" == "y" ]
then
    master_key_passphrase=$(gpg --gen-random --armor 0 24)
    echo -e "\nKeep this in a secure location.  ${master_key_passphrase}  \n"
fi


echo -e "\n Hit enter to continue with the key creation"
read -r 
cd $gnupg_home


username=$(git config --global user.name)
email=$(git config --global user.email)

echo "Using identity from Git config"
echo -e "\n Current values:"
echo "user.name: '$username'"
echo "email: '$email'"

if [ -z "$username" ] || [ -z "$email" ]
then
	echo "Please update your git config"
	echo "git config --global user.name 'Real Name'"
	echo "git config --global user.email 'email@example.com'"
	exit
fi

#export temp_dir="$(mktemp -d)"
export GNUPGHOME="$(mktemp -d)"
cat >master_key_batch <<EOF
     %echo Generating a master OpenPGP key
     Key-Type: RSA
     Key-Length: 4096
     Key-Usage: cert
     Name-Real: $username
     Name-Email: $email
     Expire-Date: 0
     %commit
     %echo done
EOF
gpg --batch --full-generate-key master_key_batch --passphrase $master_key_passphrase cert

echo "Setting key to fully trust"
echo -e "5\ny\n" |  gpg --command-fd 0 --expert --edit-key $email trust;

master_key_id=$(gpg --list-options show-only-fpr-mbox --list-secret-keys | awk '{print $1}')

gpg --batch --passphrase $master_key_passphrase --quick-add-key $master_key_id rsa4096 sign 1y
gpg --batch --passphrase $master_key_passphrase --quick-add-key $master_key_id rsa4096 auth 1y
gpg --batch --passphrase $master_key_passphrase --quick-add-key $master_key_id rsa4096 encr 1y
