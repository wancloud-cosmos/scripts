#!/bin/bash

FLAG=`ps -ef | grep gaiad | wc -l`
if [ $FLAG -ne 2 ]; then
  source start.sh
  echo "Gaiad restarted successfully."
fi