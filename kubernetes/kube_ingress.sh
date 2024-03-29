#!/bin/bash
namespace=$(kube_namespace.sh)

if [ -z "${namespace}" ]
then
    echo "No namespace set or found"
    exit
fi

echo -e "\nFound namespace ${namespace}" 

services_list=$( microk8s.kubectl -n$namespace get services -o jsonpath={.items[*].metadata.name}  )

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
    # TODO add option for Apache too
  echo -e "\nStart wizard for an Nginx proxy pass using this service?   y/N"
  read -r -n1 option
  if [ "$option" == "y" ]
  then
      echo -e "\nKubernetes details for the service to proxy:"
      microk8s.kubectl describe service ${service_name} -n ${namespace}

      echo -e "\n Listen to which port? (e.g.  443 )"
      read -r port

      echo -e "\n What is the domain name of the service? (e.g.  test.example.com )"
      read -r domainname
      
      echo -e "\n Listing NodePorts for this service:"
      nodeports=$(microk8s.kubectl -n$namespace get services -o jsonpath={.items[*].spec.ports[*].nodePort} )

      select nodeport in ${nodeports}
      do

      if [ -z "$nodeport" ] || [ -z "$REPLY" ]
      then
          echo -e "\nNo NodePort selected.  Exiting..."
          exit
      fi

      echo -e "Using NodePort $nodeport"

        nginx_services_path="/etc/nginx/sites-available"
        proxy_pass_file="kube_$domainname"
        proxy_pass_filepath="${nginx_services_path}/${proxy_pass_file}"


        echo -e "************************"
        echo -e "\n Result template file for Nginx $proxy_pass_filepath \n Listening port: $port \n for the service in ${domainname} \n located in the Kubernetes NodePort $nodeport" 
        echo -e "************************\n\n"

        output="
server {
	access_log /var/log/nginx/kube_${domainname}.log;
	error_log /var/log/nginx/kube_${domainname}.log;

	location / {
        proxy_set_header Host ${domainname};
		proxy_pass https://localhost:${nodeport};
	}
 
     listen ${port};
     server_name ${domainname};
}

server {
      if (\$host = ${domainname}) {
          return 301 https://${domainname}\$request_uri;
      }
      server_name ${domainname};
      return 404;

	access_log /var/log/nginx/kube_${domainname}.log;
	error_log /var/log/nginx/kube_${domainname}.log;

     listen ${port};
}

server {
     if (\$host = ${domainname}) {
         return 301 https://\$host\$request_uri;
     }

	access_log /var/log/nginx/kube_${domainname}.log;
	error_log /var/log/nginx/kube_${domainname}.log;
 
     listen 80;
     server_name ${domainname};
}
        "

        echo -e "$output\n"

      echo -e "\n Is this correct?  WARNING: The file '${proxy_pass_filepath}' will be overwritten y/N"

      read -r -n1 option
      if [ "$option" == "y" ]
      then
        
        echo -e "$output" > "$proxy_pass_filepath" && echo -e "\nAdded file:\n" || echo "Could not write file $proxy_pass_filepath"
      fi

      exit
     done
  fi

done
