#!/bin/bash

string_to_encrypt=$1
user_recipient=$(git config user.email)
echo -n "$1" | gpg --encrypt --armor --recipient $user_recipient #-o encrypted.txt


