#!/bin/bash

echo "Installing Kubernetes from snap"

sudo snap install microk8s --classic

#sudo usermod -a -G microk8s kubemain

echo "Adding dns dashboard and storage services"
microk8s.enable dns dashboard storage

echo "Creating a service account"
microk8s.kubectl create -n kube-system serviceaccount admin
microk8s.kubectl -n kube-system get serviceaccount admin -o yaml


echo "Extracting the token from the created account"
secret_name=$(microk8s.kubectl -n kube-system get serviceaccount admin -o jsonpath='{.secrets[0].name}')
# microk8s.kubectl -n kube-system get secret ${secret_name} -o yaml
token=$(microk8s.kubectl -n kube-system get secret "${secret_name}" -o jsonpath='{.data.token}' | base64 --decode)



echo "EXPOSE THE DASHBOARD"
echo "Change .spec.type to NodePort"
microk8s.kubectl -n kube-system edit service kubernetes-dashboard


#kubernetes-dashboard   NodePort   10.152.183.70   <none>        443:31975/TCP   3h20m


dashboard_ip=$(microk8s.kubectl get service/kubernetes-dashboard --namespace kube-system -o jsonpath='{.spec.clusterIP}')
dashboard_port=$(microk8s.kubectl -n kube-system get service kubernetes-dashboard -o jsonpath='{.spec.ports[*].nodePort}')


echo "Now the dashboard is visible in https://localhost:${dashboard_port}"
echo "https://${dashboard_ip}:${dashboard_port}"

echo -e "The token to access the dashbaord is:\n"
echo "${token}"
echo -e "\n"
