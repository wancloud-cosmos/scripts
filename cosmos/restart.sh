#!/bin/bash

ROLE=$1
ROLE_VAL="validator"
ROLE_SENTRY="sentry"

if [ ! -n "$ROLE" ]; then
  echo "参数缺失："$ROLE_VAL" 或者 "$ROLE_SENTRY
  exit 1
fi

if [[ "$ROLE_VAL" != "$ROLE" ]] && [[ "$ROLE_SENTRY" != "$ROLE" ]]; then
  echo "必须是有效的参数："$ROLE_VAL" 或者 "$ROLE_SENTRY
  exit 1
fi

FLAG=`ps -ef | grep gaiad | wc -l`
if [ $FLAG -ne 1 ]; then
  PID=$(ps x | grep gaiad | grep -v grep | awk '{print $1}')
  echo "Kill gaia PID: "$PID
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
