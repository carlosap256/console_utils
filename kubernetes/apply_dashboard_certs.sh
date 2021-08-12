#!/bin/bash

# This assumes the dashboard is in 'kube-system' namespace, but 
# the new version seem to be in its own namespace 'kubernetes-dashboard'

certs_path="$HOME/kubernetes_cert"
dashboard_certs=$(microk8s.kubectl -n kube-system get secret kubernetes-dashboard-certs | grep "kubernetes-dashboard-certs" | awk '{print $3}')

while getopts f flag
do
    case "${flag}" in
        f) force="force";;
    esac
done


if [ "$dashboard_certs" = "0" ] | [ "$force" = "force" ];then
    echo "Deleting original secret"
    microk8s.kubectl delete secret kubernetes-dashboard-certs -n kube-system

    echo "Creating secret with dashboard keys"
    microk8s.kubectl create secret generic kubernetes-dashboard-certs --from-file="$certs_path/dashboard.key" --from-file="$certs_path/dashboard.crt" -n kube-system
    
    echo "Delete dashboard pods to restart them with the certs"
    microk8s.kubectl get pod -n kube-system | grep "dashboard" |  awk '{print "microk8s.kubectl delete po " $1 " -n kube-system"}' | sh

else
    echo "Dashboard already has certs installed (You can use -f to force install)"
fi



