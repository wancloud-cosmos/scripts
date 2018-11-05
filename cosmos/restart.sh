#!/bin/bash

FLAG=`ps -ef | grep "gaiad" | wc -l`
if [ $FLAG -ne 1 ]; then
  PID=$(ps x | grep gaiad | grep -v grep | awk '{print $1}')
  echo "Kill gaia PID:"$PID
  kill $PID
fi

source start.sh
