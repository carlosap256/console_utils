#!/bin/bash

# Uses Cup as a docker
# https://cup.sergi0g.dev/docs

docker run -tv /var/run/docker.sock:/var/run/docker.sock --name dkr_updates_check --rm ghcr.io/sergi0g/cup check
