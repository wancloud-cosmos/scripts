#!/bin/bash

source ~/.profile

echo "Check IRIS process."

FLAG=`ps -ef | grep "iris start" | wc -l`
if [ $FLAG -ne 2 ]; then
  nohup iris start --home /data/.gaiad > /data/iris.log 2>&1 &
  echo "IRIS process checked failure and restarted successfully."
fi