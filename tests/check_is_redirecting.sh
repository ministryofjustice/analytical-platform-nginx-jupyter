#!/bin/bash

docker-compose logs

cmd=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:"$PROXY_PORT"/)
if [[ $cmd -ne 302 ]]; then
  echo "Test failed because curl responded with a $cmd"
  exit 1
else
  echo "Test passed"
  exit 0
fi
