#!/usr/bin/env bash

XHOME=$(cd "$(dirname "$0")"; pwd)

cd $XHOME

docker build -t "postgres-hadoop:latest" .

cat run.sh.template > ../bin/run-postgres.sh

chmod +x ../bin/*.sh
