#!/bin/bash

current_path=$(pwd)
config_namespace_file="config_namespace.yml"

if [ -f "${current_path}/${config_namespace_file}" ]; then
    cat "${current_path}/${config_namespace_file}" | yq e .metadata.name -
fi
