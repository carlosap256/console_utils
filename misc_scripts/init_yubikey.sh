#!/bin/bash

sudo add-apt-repository ppa:yubico/stable && sudo apt-get update

sudo apt install yubikey-manager
sudo apt install yubikey-personalization-gui
sudo apt install gnupg pcscd scdaemon
mkdir ~/.gnupg
cd ~/.gnupg

cat > ~/.gnupg/scdaemon.conf <<'EOF'
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

echo "trust-model tofu+pgp" > ~/.gnupg/gpg.conf 

systemctl --user restart gpg-agent.service



