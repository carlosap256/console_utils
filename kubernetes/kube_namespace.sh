#!/bin/bash

current_path=$(pwd)
kustomization_file="kustomization.yaml"
config_namespace_file="config_namespace.yml"

# TODO support all the kustomization versions (yaml, yml, etc)
if [ -f "${current_path}/${kustomization_file}" ]; then
    cat "${current_path}/${kustomization_file}" | yq e .namespace -
    exit
fi

if [ -f "${current_path}/${config_namespace_file}" ]; then
    cat "${current_path}/${config_namespace_file}" | yq e .metadata.name -
fi
