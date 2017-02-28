#!/usr/bin/env bash

#JAVA_HOME=

SOFT_DIR="/media/sda5/soft"

ZOO_VERSION="3.4.9"
HADOOP_VERSION="2.7.3"
HBASE_VERSION="1.2.4"

DOCKER_ADD_HOST="\
	--add-host zoo1.zookeeper:172.17.0.2\
	--add-host zoo2.zookeeper:172.17.0.3\
	--add-host zoo3.zookeeper:172.17.0.4\
	--add-host journal.hadoop:172.17.0.5\
	--add-host master1.hadoop:172.17.0.6\
	--add-host master2.hadoop:172.17.0.7\
	--add-host data1.hadoop:172.17.0.8\
	--add-host data2.hadoop:172.17.0.9\
	--add-host data3.hadoop:172.17.0.10\
	"
