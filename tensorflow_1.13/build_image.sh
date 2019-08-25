#!/bin/sh
set -e 

DOCKERFILE=./Dockerfile
#DOCKERFILE=./Dockerfile.gpu

USER_ID=$(id -u)

docker build -f ${DOCKERFILE}                         \
  -t "tftest:1.13"                                    \
  --no-cache=true                                     \
  --build-arg USER_NAME=tftest                        \
  --build-arg UID=${USER_ID}                          \
  --build-arg http_proxy=${http_proxy}                \
  --build-arg https_proxy=${https_proxy}              \
  .
