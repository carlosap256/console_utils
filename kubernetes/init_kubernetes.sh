#!/bin/bash


is_kube_installed=$(snap info microk8s | grep "installed")
if [ -z "$is_kube_installed" ];then
    echo "Installing Kubernetes from snap"
    sudo snap install microk8s --classic
else
    kube_version=$(echo "${is_kube_installed}" | awk '{print $2}')
    echo "Kubernetes already installed"
    echo "Version ${kube_version}"
    echo ""
fi

username=$(whoami)
user_in_kubernetes_group=$(groups ${username} | grep "microk8s")

if [ -z "$user_in_kubernetes_group" ];then
    echo "Adding current user to microk8s group"
    sudo usermod -a -G microk8s "${username}"
    echo "Need log out and in again and rerun this script for the changes to take effect"
else
    echo "Current user is already in Kubernetes group"
    echo ""
fi

echo "Adding dns dashboard and storage services"
microk8s.enable dns dashboard storage


admin_service_account=$(microk8s.kubectl -n kube-system get serviceaccount admin -o yaml)
if [ -z "$admin_service_account" ];then

    echo "Creating a service account"
    microk8s.kubectl create -n kube-system serviceaccount admin
else
    echo "Admin account already created"
    echo ""
fi

echo "Extracting the token from the admin account"
secret_name=$(microk8s.kubectl -n kube-system get serviceaccount admin -o jsonpath='{.secrets[0].name}')
token=$(microk8s.kubectl -n kube-system get secret "${secret_name}" -o jsonpath='{.data.token}' | base64 --decode)


dashboard_spec_type=$(microk8s.kubectl -n kube-system get service kubernetes-dashboard -o jsonpath='{.spec.type}')
if [ "$dashboard_spec_type" = "NodePort" ]; then
    echo "Dashboard already exposed"
    echo ""
else
    echo "EXPOSE THE DASHBOARD"
    echo "Changing .spec.type to NodePort"
    #microk8s.kubectl -n kube-system edit service kubernetes-dashboard
    #kubernetes-dashboard   NodePort   10.152.183.70   <none>        443:31975/TCP   3h20m
    microk8s.kubectl -n kube-system patch service kubernetes-dashboard -p '{"spec":{"type":"NodePort"}}'
fi

dashboard_ip=$(microk8s.kubectl get service/kubernetes-dashboard --namespace kube-system -o jsonpath='{.spec.clusterIP}')
dashboard_port=$(microk8s.kubectl -n kube-system get service kubernetes-dashboard -o jsonpath='{.spec.ports[*].nodePort}')


echo -e "\n\nThe dashboard is visible in"
echo -e "https://localhost:${dashboard_port}"
echo -e "https://${dashboard_ip}:${dashboard_port}"

echo -e "\n\nThe token to access the dashboard is:\n"
kube_get_token.sh
echo -e "\n"
