#!/bin/bash

if [ ! -d $GOPATH ]; then
  echo "Please set GOPATH"
  exit 1
fi

TARGET_PATH=$GOPATH/src/github.com/irisnet
#TARGET_PATH=/Users/trevorfu/shell_test

if [ ! -d $TARGET_PATH ]; then
  echo "The directory does not exist, TARGET_PATH: "$TARGET_PATH
  exit 1
else
  cd $TARGET_PATH
fi

IRISHUB_PATH=$TARGET_PATH"/irishub"
echo "IRIS-HUB path: "$IRISHUB_PATH

VERSION=$1
if [ ! -n "$VERSION" ]; then
  VERSION="master"
fi
echo "The current version of IRIS-HUB is: "$VERSION

if [ ! -d $IRISHUB_PATH ]; then
  git clone https://github.com/irisnet/irishub.git
  cd irishub
  git checkout $VERSION
else
  cd irishub
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

IRISD=$GOPATH"/bin/iris"
IRISCLI=$GOPATH"/bin/iriscli"
echo "Source file: "$IRISD", "$IRISCLI

#TARGET_HOSTS=('gos-validator' 'gos-sentry1' 'gos-sentry2')
TARGET_HOSTS=('uc' 'gos-sentry1' 'gos-sentry2')

for HOST in ${TARGET_HOSTS[@]}
do
  echo "Target Server: "$HOST
  scp $IRISD ubuntu@$HOST:/home/ubuntu/bin/
  scp $IRISCLI ubuntu@$HOST:/home/ubuntu/bin/
done


