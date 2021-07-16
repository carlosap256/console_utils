#!/bin/bash

# This assumes the dashboard is in 'kube-system' namespace, but 
# the new version seem to be in its own namespace 'kubernetes-dashboard'

echo "Deleting original empty secret"
microk8s.kubectl delete secret kubernetes-dashboard-certs -n kube-system

echo "Creating secret with dashboard keys"
microk8s.kubectl create secret generic kubernetes-dashboard-certs --from-file="$HOME/kubernetes_cert/dashboard.key" --from-file="$HOME/kubernetes_cert/dashboard.crt" -n kube-system

echo "Delete dashboard pods to restart them with the certs"
microk8s.kubectl get pod -n kube-system | grep "dashboard" |  awk '{print "kubectl delete po " $1 " -n kube-system"}' | sh



