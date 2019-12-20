#!/usr/bin/env bash

docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name docker_registry \
  -v ${REGISTRY_VOLUME}:/var/lib/registry \
  registry:2