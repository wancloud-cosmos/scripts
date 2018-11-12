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
chmod +x gaia*

MONIKER="wancloud"
if [ "$ROLE_SENTRY" == "$ROLE" ]; then
  MONIKER="wancloud-sentry"
fi

if [ ! -f "/data/.gaiad/config/genesis.json" ]; then
  echo "The genesis file does not exist"
  gaiad init --home-client /data/.gaiacli --chain-id gaia-9000 --moniker $MONIKER
fi

nohup gaiad start > /data/gaia.log 2>&1 &

