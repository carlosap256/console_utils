#!/bin/bash

# TODO I'll keep this here for a while, but it will be replaced by Kustomize

current_path=$(pwd)
current_namespace=$(kube_namespace.sh)

if [ -z "$current_namespace" ];
then
    echo "No namespace detected"
    exit
else
    echo "Current namespace: $current_namespace"

    echo -e "\nRename namespace to what? "
    
    read -r  new_namespace
    if [ -z "$new_namespace" ]
    then
        echo "Cannot rename to empty namespace"
        exit
    else
        if [ "$new_namespace" == "$current_namespace" ]
        then
            echo "New namespace is the same as the current one"
            exit
        else
            
            yml_files=$(ls -l *.yml | awk '{ print $9 }')

            for yml_file in ${yml_files}
            do
                echo -e "\n Renaming namespace for file: $yml_file"
                # TODO
                #cat $yml_file | yq e -P -
            done
        fi
    fi
fi

