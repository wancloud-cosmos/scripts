#!/bin/bash

if [ ! -d $GOPATH ]; then
  echo "Please set GOPATH"
  exit 1
fi

TARGET_PATH=$GOPATH/src/github.com/cosmos
#TARGET_PATH=/Users/trevorfu/shell_test

if [ ! -d $TARGET_PATH ]; then
  echo "The directory does not exist, TARGET_PATH: "$TARGET_PATH
  exit 1
else
  cd $TARGET_PATH 
fi

SDK_PATH=$TARGET_PATH"/cosmos-sdk"
echo "COSMOS-SDK path: "$SDK_PATH

VERSION=$1
if [ ! -n "$VERSION" ]; then
  VERSION="master"
fi 
echo "The current version of COSMOS-SDK is: "$VERSION

if [ ! -d $SDK_PATH ]; then
  git clone https://github.com/cosmos/cosmos-sdk.git 
  cd cosmos-sdk
  git checkout $VERSION
else
  cd cosmos-sdk
  git fetch --all && git checkout $VERSION
  git pull
fi

make get_tools && make update_tools
make get_vendor_deps
make install > /tmp/error
if [ $? -ne 0 ]; then
  echo "Executing 'make install' failed"
  exit 1
fi

GAIAD=$GOPATH"/bin/gaiad"
GAIACLI=$GOPATH"/bin/gaiacli"
echo "Source file: "$IRISD", "$IRISCLI

TARGET_HOSTS=('gos-validator' 'gos-sentry1' 'gos-sentry2')
#TARGET_HOSTS=('uc' 'gos-sentry1' 'gos-sentry2')

for HOST in ${TARGET_HOSTS[@]}
do
  echo "Target Server: "$HOST
  scp $GAIAD ubuntu@$HOST:/home/ubuntu/bin/
  scp $GAIACLI ubuntu@$HOST:/home/ubuntu/bin/
done
