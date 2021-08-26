#!/bin/bash

secret_list=$(kustomize cfg grep "kind=Secret" . | yq e '.metadata.annotations."config.kubernetes.io/path"' -)

if [ -z "$secret_list" ]
then
    echo -e "\nNo secret yml files found"
    exit
fi

echo -e "Secret files found:\n"
echo "$secret_list"

echo -e "\n\nCreate example_secret.yml files with empty secrets?   y/N"
read -r -n1 option
if [ "$option" == "y" ]
then
    for secret_file in ${secret_list}
    do
       example_file=$(cat "${secret_file}" | yq e '.data[] |= "----PASSWORD IN BASE64----" ' -)
       echo -e "\n$example_file"
       echo -e "\n\nWrite file ${secret_file}.example y/N?"
       read -r -n1 option
       if [ "$option" == "y" ]
       then
            echo "$example_file" > "${secret_file}.example"
       fi
    done

    # TODO Do this automatically
    echo -e "\n\nRemember to add the original secret files to .gitignore"
    echo "-------"
    echo "$secret_list"
    echo "-------"
fi


