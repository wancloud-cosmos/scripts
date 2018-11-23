#!/bin/bash

cd ~
source .profile

echo "Check gaiad process."

FLAG=`ps -ef | grep gaiad | wc -l`
if [ $FLAG -ne 2 ]; then
  su ubuntu
  cd ~
  nohup gaiad start --home /data/.gaiad > /data/gaia.log 2>&1 &
  echo "Gaiad checked failure and restarted successfully."
fi