#!/bin/sh

docker-compose -f build/package/local/docker-compose.yaml up --build || elm-spa watch
