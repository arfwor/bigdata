#!/usr/bin/env bash

XHOME=$(cd "$(dirname "$0")"; pwd)

cd $XHOME

docker build -t "basic-ubuntu:latest" .
