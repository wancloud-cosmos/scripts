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

cd ~
chmod +x iris*

MONIKER="wancloud"
if [ "$ROLE_SENTRY" == "$ROLE" ]; then
  MONIKER="wancloud-sentry"
fi

iris init --home-client /data/.iriscli --name afu --chain-id fuxi-3001

nohup iris start > /data/iris.log 2>&1 &
