#!/bin/bash
namespace=$(kube_namespace.sh)

if [ -z "${namespace}" ]
then
    echo "No namespace set or found"
    exit
fi

echo -e "\nFound namespace ${namespace}" 

pod_list=$(microk8s.kubectl -n ${namespace} get pods -o jsonpath='{.items[*].metadata.name}')

if [ -z "$pod_list" ]
then
    echo -e "\nNo pods found in namespace"
    exit
fi

echo -e "\n\nPods:"

select pod_name in ${pod_list}
do

  if [ -z "$pod_name" ] || [ -z "$REPLY" ]
  then
      echo -e "\nNo pod selected.  Exiting..."
      exit
  fi

  echo -e "\n\nUsing pod: $pod_name"

  echo -e "\nDescribe pod (d), list events once (e), show logs (l), \nfollow events with watch (f), or execute bash term (x)?   d/l/e/f/x"
  read -r -n1 option
  if [ "$option" == "d" ]
  then
      echo -e "\nSelected describe"
      #microk8s.kubectl describe pod ${pod_name} -n ${namespace}
      kube_main.sh describe pod ${pod_name}
  elif [ "$option" == "l" ]
  then
      echo -e "\nSelected logs"
      #microk8s.kubectl -n ${namespace} logs ${pod_name} --follow
      kube_main.sh logs ${pod_name} --follow
  elif [ "$option" == "e" ]
  then
      echo -e "\nSelected events"
      #microk8s.kubectl get event -n ${namespace} --field-selector involvedObject.name=${pod_name}
      kube_main.sh get events --field-selector involvedObject.name=${pod_name}
  elif [ "$option" == "f" ]
  then
      echo -e "\nSelected follow"
     # watch "microk8s.kubectl get event -n ${namespace} --field-selector involvedObject.name=${pod_name}"
      watch "kube_main.sh get events --field-selector involvedObject.name=${pod_name}"
  elif [ "$option" == "x" ]
  then
      echo -e "\nSelected bash term"
      #microk8s.kubectl -n ${namespace} exec -it ${pod_name} -- /bin/bash
      kube_main.sh exec -it ${pod_name} -- /bin/bash
  fi

done
