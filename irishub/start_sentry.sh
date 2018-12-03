#!/bin/bash

CHAIN_ID=$1

cd $HOME/bin
chmod +x *
cd ~

IRIS_HOME=/data/.iris
echo "The currently specified iris-home is: "$IRIS_HOME

if [ ! -f $IRIS_HOME"/config/genesis.json" ]; then
  echo "The 'genesis.json' file does not exist, 'iris init' initialization:"

  if [ ! -n "$CHAIN_ID" ]; then
    echo "The parameter is missing, please enter chain-id"
    exit 1
  fi

  echo "The current 'chain-id' is: "$CHAIN_ID
  iris init --home=$IRIS_HOME --chain-id=$CHAIN_ID --moniker=wancloud-sentry

  echo "Please update the 'genesis.json' & 'config.toml' configuration in the '"$IRIS_HOME"/config/' directory, and then execute this command again."
  exit 0
fi

echo "'iris start' starts sentry node!"
nohup iris start --home=$IRIS_HOME > /data/iris.log 2>&1 &
