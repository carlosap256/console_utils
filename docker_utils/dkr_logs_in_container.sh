#!/bin/bash


echo -e "Logs from which container?\n"

docker ps

echo -e "\n\n"

container_list=$( docker ps --format "{{.Names}}" )

if [ -z "$container_list" ]
then
    echo -e "\nNo containers running"
    exit
fi


select container_name in ${container_list}
do

  if [ -z "$container_name" ] || [ -z "$REPLY" ]
  then
      echo -e "\nNo container selected.  Exiting..."
      exit
  fi

  echo -e "\n\nShowing logs from container: $container_name"
  
  docker logs --tail 50 --follow --timestamps $container_name
  #docker exec -it $container_name /bin/sh
done

