#!/bin/bash

source ~/.profile

echo "Check IRIS process."

FLAG=`ps -ef | grep "iris start" | grep -v grep | wc -l`
if [ $FLAG -ne 1 ]; then
  nohup iris start --home /data/.iris > /data/iris.log 2>&1 &
  echo "IRIS process checked failure and restarted successfully."
else
  echo "IRIS process is running …… "
fi