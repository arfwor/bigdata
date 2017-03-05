#!/usr/bin/env bash

SOFT_DIR="/media/sda5/soft"

#JAVA_HOME=
#SCALA_HOME=

ZOO_VERSION="3.4.9"
HADOOP_VERSION="2.7.3"
HBASE_VERSION="1.2.4"
#HIVE_VERSION="2.1.1"
# spark thriftserver 对接只能 1.x 版本
HIVE_VERSION="1.2.1"
SPARK_VERSION="2.1.0"

DOCKER_ADD_HOST="\
	--add-host zoo1.hadoop:172.17.0.2\
	--add-host zoo2.hadoop:172.17.0.3\
	--add-host zoo3.hadoop:172.17.0.4\
	--add-host postgres.hadoop:172.17.0.5\
	--add-host journal.hadoop:172.17.0.6\
	--add-host name1.hadoop:172.17.0.7\
	--add-host name2.hadoop:172.17.0.8\
	--add-host hbase1.hadoop:172.17.0.9\
	--add-host hbase2.hadoop:172.17.0.10\
	--add-host hive1.hadoop:172.17.0.11\
	--add-host hive2.hadoop:172.17.0.12\
	--add-host spark1.hadoop:172.17.0.13\
	--add-host spark2.hadoop:172.17.0.14\
	--add-host data1.hadoop:172.17.0.15\
	--add-host data2.hadoop:172.17.0.16\
	--add-host data3.hadoop:172.17.0.17\
	"
