#!/bin/bash


echo -e "Attach to which container?\n"

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

  echo -e "\n\nAttaching to container: $container_name"


 if [ -z "`is_windows.sh`" ]
 then
   docker exec -it $container_name /bin/sh
 else
   winpty  docker exec -it $container_name /bin/sh
 fi
done

