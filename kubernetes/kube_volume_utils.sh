#!/bin/bash

namespace=$(kube_namespace.sh)

if [ -z "${namespace}" ]
then
    echo "No namespace set or found"
    exit
fi

echo -e "\nFound namespace ${namespace}" 

persistent_volumes_array=$(microk8s.kubectl -n $(kube_namespace.sh) get pv -o yaml | yq e "[ (.items[] | select(.spec.claimRef.namespace == \"${namespace}\" )) ] " - )
persistent_volumes_names=$(microk8s.kubectl -n $(kube_namespace.sh) get pv -o yaml | yq e "[ (.items[] | select(.spec.claimRef.namespace == \"${namespace}\" )) ] | .[].spec.claimRef.name " - )

if [ -z "$persistent_volumes_names" ]
then
    echo -e "\nNo persistent volumes found in namespace"
    exit
fi

echo -e "\n\nPersistent Volumes:"

select volume_name in ${persistent_volumes_names}
do

  if [ -z "$volume_name" ] || [ -z "$REPLY" ]
  then
      echo -e "\nNo volume selected.  Exiting..."
      exit
  fi

  echo -e "\n\nUsing volume: $volume_name"


  echo -e "\nGet volume info (g), Get volume real path (p), Issue SSL certificates for localhost in that path (c)?    g/p/c"
  read -r -n1 option
  if [ "$option" == "g" ]
  then
      echo -e "\nSelected volume info"
      #microk8s.kubectl -n $namespace get pv -o yaml | yq e .items["$(($REPLY-1))"] -
      echo "$persistent_volumes_array" | yq e .["$(($REPLY-1))"] -

  elif [ "$option" == "p" ]
  then
      echo -e "\nSelected get real path"
      #microk8s.kubectl -n $namespace get pv -o yaml | yq e .items["$(($REPLY-1))"].spec.hostPath.path -
      echo "$persistent_volumes_array" | yq e .["$(($REPLY-1))"].spec.hostPath.path -
  elif [ "$option" == "c" ]
  then
      echo -e "\nSelected issue certificates"
      #output_path=$(microk8s.kubectl -n $namespace get pv -o yaml | yq e .items["$(($REPLY-1))"].spec.hostPath.path -)
      output_path=$( echo "$persistent_volumes_array"  | yq e .["$(($REPLY-1))"].spec.hostPath.path -)
      sudo openssl req -x509 -nodes -newkey rsa:4096 -keyout "${output_path}/privkey_local.pem" -out "${output_path}/fullchain_local.pem" -days 1 -subj "/CN=localhost"
      echo -e "\nKeys created in path: \n${output_path} \n\nPrivate key: privkey_local.pem  \t Certificate: fullchain_local.pem"
  fi

  exit
done
