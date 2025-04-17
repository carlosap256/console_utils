#!/binb/bash

# Uses Cup as a docker
# https://cup.sergi0g.dev/docs

docker run -tv /var/run/docker.sock:/var/run/docker.sock ghcr.io/sergi0g/cup check
