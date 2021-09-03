#!/bin/bash

file_to_verify=$1

gpg --verify $file_to_verify
