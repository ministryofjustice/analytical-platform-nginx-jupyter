#!/bin/bash
cmd=$(curl -s -o /dev/null -w "%{http_code}" localhost:8001)
if [[ $cmd -ne 302 ]]; then
  echo "Test failed because curl responded with a $cmd"
  exit 1
else
  echo "Test passed"
  exit 0
fi