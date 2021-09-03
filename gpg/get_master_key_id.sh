#!/bin/bash

gpg --list-options show-only-fpr-mbox --list-secret-keys | awk '{print $1}'
