#!/bin/bash

FLAG=`ps -ef | grep iris | wc -l`
if [ $FLAG -ne 1 ]; then
  PID=$(ps x | grep iris | grep -v grep | awk '{print $1}')
  echo "Kill iris PID: "$PID
  kill $PID
fi

source start.sh
