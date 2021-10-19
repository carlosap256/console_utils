#!/bin/bash
file_to_decrypt=$1
gpg --decrypt --armor $file_to_decrypt
