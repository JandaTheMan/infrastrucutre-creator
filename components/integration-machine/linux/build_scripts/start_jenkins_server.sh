#!/usr/bin/env bash
set -ex
source ${constants_file}
docker run \
  --restart always \
  -d \
  -v ${JENKINS_VOLUME}:/var/jenkins_home \
  -p 80:8080 \
  -p 50000:50000 \
  --name jenkins_server \
  jenkins/jenkins
