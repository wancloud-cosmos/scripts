#!/bin/bash

if [ ! -d $GOPATH ]; then
  echo "请先设置GOPATH"
  exit 1
fi

TARGET_PATH=$GOPATH/src/github.com/irisnet
#TARGET_PATH=/Users/trevorfu/shell_test

if [ ! -d $TARGET_PATH ]; then
  echo "目录不存在，TARGET_PATH:$TARGET_PATH"
  exit 1
else
  cd $TARGET_PATH
fi

IRISHUB_PATH=$TARGET_PATH"/irishub"
echo "IRISHUB路径:"$IRISHUB_PATH

VERSION=$1
if [ ! -n "$VERSION" ]; then
  VERSION="master"
fi
echo "指定当前版本为："$VERSION

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
  echo "'make install'失败"
  exit 1
fi

IRISD=$GOPATH"/bin/iris"
IRISCLI=$GOPATH"/bin/iriscli"
echo "源文件:$IRISD,$IRISCLI"

#TARGET_HOSTS=('gos-validator' 'gos-sentry1' 'gos-sentry2')
TARGET_HOSTS=('uc' 'gos-sentry1' 'gos-sentry2')

for HOST in ${TARGET_HOSTS[@]}
do
  echo "目标服务器:$HOST"
  scp $IRISD ubuntu@$HOST:/home/ubuntu/bin/
  scp $IRISCLI ubuntu@$HOST:/home/ubuntu/bin/
done


