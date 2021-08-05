#!/bin/bash
namespace=$(kube_namespace.sh)

if [ -z "${namespace}" ]
then
    echo "No namespace set or found"
    exit
fi

echo -e "\nFound namespace ${namespace}" 

statefulset_list=$(microk8s.kubectl -n $namespace get statefulset -o yaml | yq e .items[].metadata.name -)

if [ -z "$statefulset_list" ]
then
    echo -e "\nNo statefulsets found in namespace"
    exit
fi

echo -e "\n\nStatefulsets:"

select sfs_name in ${statefulset_list}
do

  if [ -z "$sfs_name" ] || [ -z "$REPLY" ]
  then
      echo -e "\nNo statefulset selected.  Exiting..."
      exit
  fi

  echo -e "\n\nUsing statefulset: $sfs_name"

  current_replicas=$(microk8s.kubectl -n $namespace describe statefulset $sfs_name | yq e .Replicas -)
  echo -e "\n Current Replicas: ${current_replicas}"

  echo -e "\nDescribe statefulset (d), Refresh replica status, or scale replicas (s)?   d/r/s"
  read -r -n1 option
  if [ "$option" == "d" ]
  then
      echo -e "\nSelected describe"
      microk8s.kubectl describe statefulset ${sfs_name} -n ${namespace}
  elif [ "$option" == "r" ]
  then
      current_replicas=$(microk8s.kubectl -n $namespace describe statefulset $sfs_name | yq e .Replicas -)
      echo -e "\n Current Replicas: ${current_replicas}"
  elif [ "$option" == "s" ]
  then
      echo -e "\nSelected scale"

      echo -e "\nHow many replicas? "
      read -r -n1 replicas
      microk8s.kubectl -n ${namespace} scale --replicas=${replicas} statefulset/${sfs_name}
  fi

done
