#!/bin/bash

# Import Boilerplate scripts
export PATH=$PATH:${GITHUB_PATH}${UTILS_REPO}/bin/boilerplate

pid=$$


bp_force_sudo_or_die $pid  

echo "The script was run as sudo"
