#!/bin/bash

namespace=$(kube_namespace.sh)

if [ -z "${namespace}" ]
then
    echo "No namespace set or found"
    exit
fi

echo -e "\nFound namespace ${namespace}" 

persistent_volumes=$(microk8s.kubectl -n ${namespace} get persistentvolume -o yaml | yq e .items[].spec.claimRef.name -)

if [ -z "$persistent_volumes" ]
then
    echo -e "\nNo persistent volumes found in namespace"
    exit
fi

echo -e "\n\nPersistent Volumes:"

select volume_name in ${persistent_volumes}
do

  if [ -z "$volume_name" ] || [ -z "$REPLY" ]
  then
      echo -e "\nNo volume selected.  Exiting..."
      exit
  fi

  echo -e "\n\nUsing volume: $volume_name"


  echo -e "\nGet volume info (g), Get volume real path (p)?    g/p"
  read -r -n1 option
  if [ "$option" == "g" ]
  then
      echo -e "\nSelected volume info"
      microk8s.kubectl -n $namespace get pv -o yaml | yq e .items["$(($REPLY-1))"] -

  elif [ "$option" == "p" ]
  then
      echo -e "\nSelected get real path"
      microk8s.kubectl -n $namespace get pv -o yaml | yq e .items["$(($REPLY-1))"].spec.hostPath.path -
  fi

  exit
done
