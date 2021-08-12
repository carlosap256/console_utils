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

 echo -e "\nGenerate Certbot certificates (c), or Self signed certificates (s)?   c/s"
  read -r -n1 option
  if [ "$option" == "c" ]
  then
      echo -e "\nRunning certbot using webroot scheme"
 
      echo -e "\nWhich is the domain name for the Kubernetes dashboard?"
  #    read -r domainname
   #   sudo certbot certonly --webroot -w /var/www/html -d $domainname

    domainname="kube.citizenforensics.org"  
    certbot_certpath="/etc/letsencrypt/live"
    fullchain="$certbot_certpath/$domainname/cert.pem"
    privkey="$certbot_certpath/$domainname/privkey.pem"

    sudo cp ${fullchain} ${output_dir}/dashboard.crt
    sudo cp ${privkey} ${output_dir}/dashboard.key
    sudo chown ops:ops ${output_dir}/dashboard.*
    

  elif [ "$option" == "s" ]
  then
      echo "Generating self signed dashboard keys in ${output_dir}"
      openssl req -newkey rsa:4096 -x509 -sha256 -nodes -out dashboard.crt -keyout dashboard.key
  fi



cd "${current_dir}" || exit

