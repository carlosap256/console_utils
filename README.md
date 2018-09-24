# Console Utils

This is a repository to try and have a consistent number of tools and configuration to work with.
I got tired of having to manually export and import the configurations for Bash, VIM, etc, on any new machine I use, so this approach helps me to quickly import/export configurations between machines.
For now it only has Bash, Vim and Aliases configuration files in /misc_scripts


## First time import

To import the configuration for the first time, enter /misc_scripts folder and run ./import_scripts.sh (need to install the dependencies first, explained below)
Then enter to a new bash console to use the new configuration.
For the second time and up, it's not necessary to enter to the folder, as it will be added to the PATH variable

## Export

To export any changes made to the bash/vim aliases files, run the script: export_scripts.sh and then commit the changes to Git


## Install dependencies

Enter the folder /dependencies and run the script ./apt.sh with sudo permissions


