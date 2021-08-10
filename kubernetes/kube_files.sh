#!/bin/bash
namespace=$(kube_namespace.sh)

if [ -z "${namespace}" ]
then
    echo "No namespace set or found"
    exit
fi

echo -e "\nFound namespace ${namespace}" 

yml_files=$(ls -l *.yml | awk '{ print $9 }')

echo -e "\nFound the following YAML files:"

select yml_file in ${yml_files}
do

 if [ -z "$yml_file" ] || [ -z "$REPLY" ]
  then
      echo -e "\nNo file selected.  Exiting..."
      exit
  fi

  echo -e "\n\nUsing file: $yml_file"

  echo -e "\nCreate resource (c), Replace resource (r), or delete resource (d)?   c/r/d"
  read -r -n1 option
  if [ "$option" == "c" ]
  then
      echo -e "\nCreating resource from file"
      microk8s.kubectl create -f ${yml_file} -n ${namespace}

      if [ "${yml_file}" == "config_namespace.yml" ]
      then
        
          echo -e "\nCreate all the other resources?   y/N"
          read -r -n1 option
          if [ "$option" == "y" ]
          then
                for file in $yml_files
                do
                    if [ "file" != "config_namespace.yml" ]
                    then
                        echo "microk8s.kubectl create -f ${yml_file} -n ${namespace}"
                    fi
                done
          fi

      fi

  elif [ "$option" == "r" ]
  then
      echo -e "\nReplacing resource from file"
      microk8s.kubectl replace -f ${yml_file} -n ${namespace}
  elif [ "$option" == "d" ]
  then
      echo -e "\nDeleting resource from file"
      microk8s.kubectl delete -f ${yml_file} -n ${namespace}
  fi

done
