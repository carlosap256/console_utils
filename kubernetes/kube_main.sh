#!/bin/bash

# Shorthand to run kubectl commands using the current namespace from the folder

namespace=$(kube_namespace.sh)
if [ -z $namespace ]
then
    namespace="kube-system"
fi
echo -e "\nUsing namespace: $namespace\n"

microk8s.kubectl -n$namespace $@
