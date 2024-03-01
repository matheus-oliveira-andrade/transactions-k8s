#!/bin/bash

# login to push images to Docker Hub, requires entering username and password
docker login


# build and push fluentd docker image
docker build -t micrommath/fluentd ./fluentd

docker image push micrommath/fluentd


# build and push transactions movement api docker image
docker build \
  --tag micrommath/transaction-movements-api \
  --file ./transactions-movements-app/Dockerfile.Api \
  ./transactions-movements-app

docker image push micrommath/transaction-movements-api


# build and push transactions movement async receiver docker image
docker build \
  --tag micrommath/transaction-movements-async-receiver \
  --file ./transactions-movements-app/Dockerfile.AsyncReceiver \
  ./transactions-movements-app

docker image push micrommath/transaction-movements-async-receiver


# build and push transactions seed docker image
docker build \
  --tag micrommath/transactions-seed \
  ./transactions-seed-app

docker image push micrommath/transactions-seed