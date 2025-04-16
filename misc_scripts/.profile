# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export PYTHONSTARTUP=$HOME/.python-startup.py
export GITHUB_PATH=$HOME/GitHub
export UTILS_REPO=/console_utils

export PATH=$PATH:${GITHUB_PATH}${UTILS_REPO}/bin
export PATH=$PATH:${GITHUB_PATH}${UTILS_REPO}/bin/boilerplate
export PATH=$PATH:${GITHUB_PATH}${UTILS_REPO}/kubernetes
export PATH=$PATH:${GITHUB_PATH}${UTILS_REPO}/gpg
export PATH=$PATH:${GITHUB_PATH}${UTILS_REPO}/docker_utils
export PATH=$PATH:${GITHUB_PATH}${UTILS_REPO}/utils

# Cmake
export PATH=$PATH:/home/carlosap/Development/Cmake/cmake-3.25.1-linux-x86_64/bin
