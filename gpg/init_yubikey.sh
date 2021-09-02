#!/bin/bash

sudo add-apt-repository ppa:yubico/stable && sudo apt-get update

sudo apt install -y yubikey-manager
sudo apt install -y yubikey-personalization-gui
sudo apt install -y gnupg pcscd scdaemon

gnupg_home="$HOME/.gnupg"
echo -n "Making GNUPG home in $gnupg_home"
mkdir $gnupg_home
chmod go-rwx $gnupg_home
cd $gnupg_home


echo -n "Configuring scdaemon to pick up the Yubikey by default"

cat > $gnupg_home/scdaemon.conf <<'EOF'
disable-ccid
pcsc-driver /usr/lib/x86_64-linux-gnu/libpcsclite.so.1
card-timeout 1

# Always try to use yubikey as the first reader
# even when other smart card readers are connected
# Name of the reader can be found using the pcsc_scan command
# If you have problems with gpg not recognizing the Yubikey
# then make sure that the string here matches exacly pcsc_scan
# command output. Also check journalctl -f for errors.
reader-port Yubico Yubikey
EOF

echo "trust-model tofu+pgp" > $gnupg_home/gpg.conf 

echo -n "Configuring scdaemon to pick up the Yubikey by default"
sudo systemctl --user restart gpg-agent.service



