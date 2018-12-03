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

FLAG=`ps -ef | grep "iris start" | wc -l`
if [ $FLAG -ne 1 ]; then
  PID=$(ps x | grep "iris start" | grep -v grep | awk '{print $1}')
  echo "Kill the iris PID: "$PID
  kill $PID
fi

cd `dirname $0`
if [ "$ROLE_VAL" == "$ROLE" ]; then
  source start_validator.sh > /tmp/error
else
  source start_sentry.sh > /tmp/error
fi
if [ $? -ne 0 ]; then
  echo "IRIS failed to restart."
  exit 1
fi

echo "IRIS restarted successfully."
