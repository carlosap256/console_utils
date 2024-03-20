#!/bin/bash

# Platform options    (TODO)
# "linux64"    - Default
# "mac-arm64" 
# "mac-x64" 
# "win32" 
# "win64" 


platform="linux64"

#installer_file_url=`curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | yq e '.channels.Stable.downloads.chromedriver.[] | select(.platform == "linux64") | .url'`
installer_file_url=`curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | yq e '.channels.Stable.downloads.chromedriver.[] | select(.platform == "'${platform}'") | .url'`
echo ${installer_file_url}



