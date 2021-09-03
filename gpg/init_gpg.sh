#!/bin/bash

gnupg_home="$HOME/.gnupg"
username=$(git config --global user.name)
email=$(git config --global user.email)

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

echo -e "\n Generate master key and sub keys? y/N"
read -r -n1 option
if [ "$option" == "y" ]
then
    echo -e "\n\nGenerating passphase for the master key..."
    echo -e "\nKeep this in a secure location."
    echo -e "\n ********* $(gpg --gen-random --armor 0 24) ******** \n"


    echo -e "\n Hit enter to continue with the key creation"
    read -r 
    cd $gnupg_home

    #export GNUPGHOME="$(mktemp -d)"
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
    gpg --batch --generate-key "${gnupg_home}/master_key_batch"

    echo "Setting key to fully trust"
    echo -e "5\ny\n" |  gpg --command-fd 0 --expert --edit-key $email trust;

    master_key_id=$(get_master_key_id.sh)

    echo "Creating subkeys to Sign Authenticate and Encrypt"
    gpg --batch --quick-add-key $master_key_id rsa4096 sign 1y
    gpg --batch --quick-add-key $master_key_id rsa4096 auth 1y
    gpg --batch --quick-add-key $master_key_id rsa4096 encr 1y

    echo "Export keys"
    gpg --armor --export-secret-keys $master_key_id > ${gnupg_home}/mastersub_${master_key_id}.key
    gpg --armor --export-secret-subkeys $master_key_id > ${gnupg_home}/sub_${master_key_id}.key

fi

echo -e "\n\n\nSummary of keys:"
gpg -k

echo -e "\n Export key to a public key server? y/N"
read -r -n1 option
if [ "$option" == "y" ]
    echo "Public key server"  
    #TODO
fi

echo -e "\n Print public key? y/N"
read -r -n1 option
if [ "$option" == "y" ]
then
    echo "Print public key"
    gpg --export -a
fi

echo -e "\n Set up Git to sign with this key? y/N"
read -r -n1 option
if [ "$option" == "y" ]
then
    git config --global user.signingkey $(get_master_key_id.sh)
    echo "Sign commits by adding -S:   commit -S -m 'Comment'"
fi


