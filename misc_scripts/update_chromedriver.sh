#!/bin/bash

# Legacy update file version
#############################
#release_major_number=$1
#latest_version=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${release_major_number})

#latest_version=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
#echo "Latest chrome version: $latest_version"
#wget -c https://chromedriver.storage.googleapis.com/${latest_version}/chromedriver_linux64.zip





#installer_file_url=`curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | yq e '.channels.Stable.downloads.chromedriver.[] | select(.platform == "linux64") | .url'`
installer_file_url=`./get_latest_chromedriver_url.sh`
wget ${installer_file_url}



unzip chromedriver-linux64.zip 
rm chromedriver-linux64.zip 
sudo cp -f chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
rm -r chromedriver-linux64/
