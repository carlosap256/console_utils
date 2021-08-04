#!/bin/bash


secret_name=$(microk8s.kubectl -n kube-system get serviceaccount admin -o jsonpath='{.secrets[0].name}')
token=$(microk8s.kubectl -n kube-system get secret "${secret_name}" -o jsonpath='{.data.token}' | base64 --decode)
 
echo "${token}"
