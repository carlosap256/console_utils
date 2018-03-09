#!/bin/bash

# Import Boilerplate scripts
export PATH=$PATH:~/github/hello_world/bin/boilerplate

pid=$$


bp_force_sudo_or_die $pid  

echo "The script was run as sudo"
