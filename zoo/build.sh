#!/usr/bin/env bash

XHOME=$(cd "$(dirname "$0")"; pwd)

cd $XHOME

. "$XHOME"/../conf/setenv.sh

rm -rf soft
mkdir soft

#cp $SOFT_DIR/jdk-8u112-linux-x64.tar.gz soft
cp $SOFT_DIR/zookeeper-$ZOO_VERSION.tar.gz soft

mkdir ../bin

for ((i = 1; i < 4; i++));
do
	sed 's/$ZID/'$i'/g' Dockerfile.template > Dockerfile.temp
	sed 's/$ZOO_VERSION/'$ZOO_VERSION'/g' Dockerfile.temp > Dockerfile
	sed 's/$ZID/'$i'/g' run.sh.template > ../bin/run-zoo$i.sh
	docker build -t "zoo$i:latest" .
done

chmod +x ../bin/*.sh

rm Dockerfile.temp
rm -rf Dockerfile
rm -rf soft
