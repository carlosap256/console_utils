#!/bin/bash

file_to_sign=$1
gpg --armor --clearsign $file_to_sign
