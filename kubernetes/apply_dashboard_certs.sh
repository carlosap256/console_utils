#!/bin/bash

# This assumes the dashboard is in 'kube-system' namespace, but 
# the new version seem to be in its own namespace 'kubernetes-dashboard'

dashboard_certs=$(microk8s.kubectl -n kube-system get secret kubernetes-dashboard-certs | grep "kubernetes-dashboard-certs" | awk '{print $3}')
if [ "$dashboard_certs" = "0" ];then
    echo "Deleting original empty secret"
    microk8s.kubectl delete secret kubernetes-dashboard-certs -n kube-system

    echo "Creating secret with dashboard keys"
    microk8s.kubectl create secret generic kubernetes-dashboard-certs --from-file="$HOME/kubernetes_cert/dashboard.key" --from-file="$HOME/kubernetes_cert/dashboard.crt" -n kube-system
    
    echo "Delete dashboard pods to restart them with the certs"
    microk8s.kubectl get pod -n kube-system | grep "dashboard" |  awk '{print "microk8s.kubectl delete po " $1 " -n kube-system"}' | sh

else
    echo "Dashboard already has certs installed"
fi



