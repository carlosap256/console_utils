#!/bin/bash

echo -e "Delete which docker image?\n"
docker images --filter "dangling=false" 

image_list=$( docker images --filter "dangling=false" --format "{{.Repository}}:{{.Tag}}" )
image_ids=$( docker images --filter "dangling=false" --format "{{.ID}}" )
ARRAY=( $image_ids )

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

  image_id=${ARRAY[$((REPLY - 1))]}

  echo -e "\n\nDeleting image: $image_name with id: $image_id"

  docker rmi -f $image_id
  
  exit
done

