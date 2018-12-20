#!/bin/bash

source ~/.profile

echo "Check gaiad process."

FLAG=`ps -ef | grep "gaiad start" | grep -v grep | wc -l`
if [ $FLAG -ne 1 ]; then
  nohup gaiad start --home /data/.gaiad > /data/gaiad.log 2>&1 &
  echo "Gaiad checked failure and restarted successfully."
else
  echo "Gaiad is running …… "
fi