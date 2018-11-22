#!/bin/bash

CHAIN_ID=$1

if [ ! -n "$CHAIN_ID" ]; then
  echo "参数缺失，请指定：chain-id"
  exit 1
fi

echo "当前指定的chain-id是: "$CHAIN_ID

cd ~
chmod +x gaia*

GAIAD_HOME=/data/.gaiad
GAIACLI_HOME=/data/.gaiacli
echo "当前指定的gaiad-home是: "$GAIAD_HOME
echo "当前指定的gaiacli-home是: "$GAIACLI_HOME

if [ ! -f $GAIAD_HOME"/config/genesis.json" ]; then
  echo "genesis.json文件不存在，执行'gaiad init'初始化"
  gaiad init --home=$GAIAD_HOME --home-client=$GAIACLI_HOME --chain-id=$CHAIN_ID --moniker=wancloud

  echo "请完成"$GAIAD_HOME"/config/目录下的genesis.json、config.toml配置更新，再执行本指令启动运行。"
  exit 0
fi

echo "gaiad start启动验证节点"
nohup gaiad start --home=$GAIAD_HOME > /data/gaia.log 2>&1 &
