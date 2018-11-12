#!/bin/bash

FLAG=`ps -ef | grep gaiad | wc -l`
if [ $FLAG -ne 1 ]; then
  PID=$(ps x | grep gaiad | grep -v grep | awk '{print $1}')
  echo "Kill gaia PID: "$PID
  kill $PID
fi

source start.sh > /tmp/error
if [ $? -ne 0 ];then
  echo "Gaiad failed to restart."
  exit 1
fi

echo "Gaiad restarted successfully."
