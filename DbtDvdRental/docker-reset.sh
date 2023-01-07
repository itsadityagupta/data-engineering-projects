#!/bin/bash
docker rm -f $(docker ps -aq)
docker rmi $(docker image ls -q)