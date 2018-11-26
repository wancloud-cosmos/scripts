#!/bin/bash

CHAIN_ID=$1

cd $HOME/bin
chmod +x *
cd ~

GAIAD_HOME=/data/.gaiad
echo "The currently specified giaid-home is: "$GAIAD_HOME

if [ ! -f $GAIAD_HOME"/config/genesis.json" ]; then
  echo "The 'genesis.json' file does not exist, 'gaiad init' initialization:"

  if [ ! -n "$CHAIN_ID" ]; then
    echo "The parameter is missing, please enter chain-id"
    exit 1
  fi

  echo "The current 'chain-id' is: "$CHAIN_ID
  gaiad init --home=$GAIAD_HOME --chain-id=$CHAIN_ID --moniker=wancloud-sentry

  echo "Please update the 'genesis.json' & 'config.toml' configuration in the '"$GAIAD_HOME"/config/' directory, and then execute this command again."
  exit 0
fi

echo "'gaiad start' starts sentry node!"
nohup gaiad start --home=$GAIAD_HOME > /data/gaiad.log 2>&1 &
