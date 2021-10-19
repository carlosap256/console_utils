#!/bin/bash

string_to_encrypt=$1
echo -n "$1" | gpg --encrypt --armor --recipient $(get_master_key_id.sh) #-o encrypted.txt


