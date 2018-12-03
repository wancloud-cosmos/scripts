#!/bin/bash

ROLE=$1
ROLE_VAL="validator"
ROLE_SENTRY="sentry"

if [ ! -n "$ROLE" ]; then
  echo "Parameter missing: "$ROLE_VAL" or "$ROLE_SENTRY
  exit 1
fi

if [[ "$ROLE_VAL" != "$ROLE" ]] && [[ "$ROLE_SENTRY" != "$ROLE" ]]; then
  echo "Must be a valid argument: "$ROLE_VAL" or "$ROLE_SENTRY
  exit 1
fi

FLAG=`ps -ef | grep "gaiad start" | wc -l`
if [ $FLAG -ne 1 ]; then
  PID=$(ps x | grep "gaiad start" | grep -v grep | awk '{print $1}')
  echo "Kill the gaia PID: "$PID
  kill $PID
fi

cd `dirname $0`
if [ "$ROLE_VAL" == "$ROLE" ]; then
  source start_validator.sh > /tmp/error
else
  source start_sentry.sh > /tmp/error
fi
if [ $? -ne 0 ]; then
  echo "Gaiad failed to restart."
  exit 1
fi

echo "Gaiad restarted successfully."
