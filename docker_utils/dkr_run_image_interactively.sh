#!/bin/bash

echo -e "Run which docker image?\n"
docker images --filter "dangling=false" 

image_list=$( docker images --filter "dangling=false" --format "{{.Repository}}:{{.Tag}}" )

if [ -z "$image_list" ]
then
    echo -e "\nNo images installed"
    exit
fi

echo -e "\n\n"

select image_name in ${image_list}
do

  if [ -z "$image_name" ] || [ -z "$REPLY" ]
  then
      echo -e "\nNo image selected.  Exiting..."
      exit
  fi

  echo -e "\n\nRunning image: $image_name"

  docker run -it $image_name /bin/sh

done

