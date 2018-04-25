#!/bin/bash

bp_preserve_path

# Test without sudo
( bp_force_sudo_or_die )
exitcode=$(echo "$?")

if [[ "$exitcode" = 1 ]]; then
    echo "Test without sudo successful"
else
    echo "Test without sudo failed"
fi
echo -e "\n\n"

# Test with sudo
#( sudo -E bp_force_sudo_or_die )  FIXME boilerplate is not working for sudo as it holds the root path for security

( cat $(whereis bp_force_sudo_or_die | awk '{ print $2 }') | sudo bash )
exitcode=$(echo "$?")

if [[ "$exitcode" = 0 ]]; then
    echo "Test with sudo successful"
else
    echo "Test with sudo failed"
fi


