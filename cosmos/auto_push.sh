#!/bin/bash

if [ ! -d $GOPATH ]; then
  echo "请先设置GOPATH"
  exit 1
fi

TARGET_PATH=$GOPATH/src/github.com/cosmos
#TARGET_PATH=/Users/trevorfu/shell_test

if [ ! -d $TARGET_PATH ]; then
  echo "目录不存在，TARGET_PATH:$TARGET_PATH"
  exit 1
else
  cd $TARGET_PATH 
fi

SDK_PATH=$TARGET_PATH"/cosmos-sdk"
echo "COSMOS-SDK路径:"$SDK_PATH

VERSION=$1
if [ ! -n "$VERSION" ]; then
  VERSION="master"
fi 
echo "指定当前版本为："$VERSION

if [ ! -d $SDK_PATH ]; then
  git clone https://github.com/cosmos/cosmos-sdk.git 
  cd cosmos-sdk
  git checkout $VERSION
else
  cd cosmos-sdk
  git fetch --all && git checkout $VERSION 
fi

GAIAD_PATH=$SDK_PATH"/cmd/gaia/cmd/gaiad"
GAIACLI_PATH=$SDK_PATH"/cmd/gaia/cmd/gaiacli"
cd $GAIAD_PATH
go build > /tmp/error
if [ $? -ne 0 ];then
  exit 1
fi
cd $GAIACLI_PATH
go build > /tmp/error
if [ $? -ne 0 ];then
  exit 1
fi

#make update_tools &&  make install

GAIAD=$GAIAD_PATH"/gaiad"
GAIACLI=$GAIACLI_PATH"/gaiacli"
echo "源文件:$GAIAD,$GAIACLI"
TARGET_HOSTS=('gos-validator' 'gos-sentry1' 'gos-sentry2')
for HOST in ${TARGET_HOSTS[@]}
do
  echo "目标服务器:$HOST"
  scp $GAIAD ubuntu@$HOST:/home/ubuntu/
  scp $GAIACLI ubuntu@$HOST:/home/ubuntu/
done
