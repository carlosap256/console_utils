#!/bin/bash


docker image prune -af

dangling=$(docker images -f "dangling=true" -q)

if [ -z "$dangling" ]
then
    exit
else
    docker rmi -f $dangling
fi

