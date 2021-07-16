#!/bin/bash

#vm_ip=$1
#vm_ip="10.0.2.15"
current_dir=$(pwd)

#if [ -z "$vm_ip" ]; then;
#    echo "IP should be the first argument"
#fi

output_dir="$HOME/kubernetes_cert"
mkdir "${output_dir}"
cd "${output_dir}" || exit

echo "Creating dashboard keys in "
openssl req -newkey rsa:4096 -x509 -sha256 -nodes -out dashboard.crt -keyout dashboard.key

cd "${current_dir}" || exit

