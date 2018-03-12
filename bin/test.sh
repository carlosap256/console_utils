#!/bin/bash

# Preserve the path values registered for this user, even if they have done Sudo
bp_preserve_path

pid=$$

bp_force_sudo_or_die $pid  

echo "The script was run as sudo"
