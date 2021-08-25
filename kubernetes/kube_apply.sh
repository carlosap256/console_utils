#!/bin/bash

#microk8s.kubectl apply -k .
# kubectl uses an older version of kustomize
kustomize build | microk8s.kubectl apply -f -
