#!/bin/bash

# Shorthand to run kubectl commands using the current namespace from the folder
microk8s.kubectl -n$(kube_namespace.sh) $@
