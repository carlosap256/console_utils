#!/bin/bash
namespace=$(kube_namespace.sh)

if [ -z "${namespace}" ]
then
    echo "No namespace set or found"
    exit
fi

echo -e "\nFound namespace ${namespace}" 

services_list=$( microk8s.kubectl -n$namespace get services -o jsonpath={.items[].metadata.name}  )

if [ -z "$services_list" ]
then
    echo -e "\nNo services found in namespace"
    exit
fi

echo -e "\n\nServices:"

select service_name in ${services_list}
do

  if [ -z "$service_name" ] || [ -z "$REPLY" ]
  then
      echo -e "\nNo service selected.  Exiting..."
      exit
  fi

  echo -e "\n\nUsing service: $service_name"

  echo -e "\nAdd proxy pass to Nginx using this service?   y/N"
  read -r -n1 option
  if [ "$option" == "y" ]
  then
      echo -e "\nService to proxy"
      microk8s.kubectl describe service ${service_name} -n ${namespace}

      echo -e "\n Listen to which port? "
      read -r port

      echo -e "\n What is the domain name of the service? "
      read -r domainname
      
      echo -e "\n Listing NodePorts for this service:"
      nodeports=$(microk8s.kubectl -n$namespace get services -o jsonpath={.items[].spec.ports[].nodePort} )

      select nodeport in ${nodeports}
      do

      if [ -z "$nodeport" ] || [ -z "$REPLY" ]
      then
          echo -e "\nNo NodePort selected.  Exiting..."
          exit
      fi

      echo -e "Using NodePort $nodeport"

        nginx_services_path="/etc/nginx/services-enabled"
        proxy_pass_file="kube_$domainname"
        proxy_pass_filepath="${nginx_services_path}/${proxy_pass_file}"

      echo -e "\n Adding file to Nginx $proxy_pass_filepath \n Listening port: $port for the service in ${domainname} located in the Kubernetes NodePort $nodeport" 
      echo -e "\n Is this correct?  WARNING: The file will be overwritten y/N"

      read -r -n1 option
      if [ "$option" == "y" ]
      then
        
        sudo echo -e "server {" > $proxy_pass_filepath
        sudo echo -e     "\tlisten $port;" >> $proxy_pass_filepath
        sudo echo -e     "\tserver_name $domainname;" >> $proxy_pass_filepath
        sudo echo -e     "\n\tlocation / {" >> $proxy_pass_filepath
        sudo echo -e         "\t\tproxy_pass http://localhost:${nodeport};" >> $proxy_pass_filepath
        sudo echo -e     "\t}" >> $proxy_pass_filepath
        sudo echo -e "}" >> $proxy_pass_filepath
      fi

        echo -e "\nAdded file:\n"
        cat $proxy_pass_filepath
      exit
     done
  fi

done
