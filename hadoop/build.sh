#!/usr/bin/env bash

XHOME=$(cd "$(dirname "$0")"; pwd)

cd $XHOME

. "$XHOME"/../conf/setenv.sh

rm -rf soft
mkdir soft
#cp $SOFT_DIR/jdk-8u112-linux-x64.tar.gz soft
cp $SOFT_DIR/hadoop-$HADOOP_VERSION.tar.gz soft
cp $SOFT_DIR/hbase-$HBASE_VERSION-bin.tar.gz soft

sed 's/$HADOOP_VERSION/'$HADOOP_VERSION'/g' Dockerfile.template > Dockerfile.temp1
sed 's/$HBASE_VERSION/'$HBASE_VERSION'/g' Dockerfile.temp1 > Dockerfile
docker build -t "hadoop:latest" .
rm Dockerfile.temp1
rm Dockerfile

rm -rf soft

mkdir ../bin

sed 's/$HID/journal/g' run.sh.template > ../bin/run-journal.sh.temp1
sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-journal.sh.temp1 > ../bin/run-journal.sh.temp2
sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-journal.sh.temp2 > ../bin/run-journal.sh.temp3
sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-journal.sh.temp3 > ../bin/run-journal.sh
rm ../bin/run-journal.sh.temp1
rm ../bin/run-journal.sh.temp2
rm ../bin/run-journal.sh.temp3

for ((i = 1; i < 3; i++));
do
	sed 's/$HID/master'$i'/g' run.sh.template > ../bin/run-master$i.sh.temp1
	sed 's/-p "$NN'$i'_PORT":"$NN'$i'_PORT"/-p 50070:50070/g' ../bin/run-master$i.sh.temp1 > ../bin/run-master$i.sh.temp2
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-master$i.sh.temp2 > ../bin/run-master$i.sh.temp3
	sed 's/-p "$RN'$i'_PORT":"$RN'$i'_PORT"/-p 8088:8088/g' ../bin/run-master$i.sh.temp3 > ../bin/run-master$i.sh.temp4
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-master$i.sh.temp4 > ../bin/run-master$i.sh.temp5
	sed 's/-p "$HM'$i'_PORT":"$HM'$i'_PORT"/-p 16010:16010/g' ../bin/run-master$i.sh.temp5 > ../bin/run-master$i.sh.temp6
	sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-master$i.sh.temp6 > ../bin/run-master$i.sh
	rm ../bin/run-master$i.sh.temp1
	rm ../bin/run-master$i.sh.temp2
	rm ../bin/run-master$i.sh.temp3
	rm ../bin/run-master$i.sh.temp4
	rm ../bin/run-master$i.sh.temp5
	rm ../bin/run-master$i.sh.temp6
done

for ((i = 1; i < 4; i++));
do
	sed 's/$HID/data'$i'/g' run.sh.template > ../bin/run-data$i.sh.temp1
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-data$i.sh.temp1 > ../bin/run-data$i.sh.temp2
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-data$i.sh.temp2 > ../bin/run-data$i.sh.temp3
	sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-data$i.sh.temp3 > ../bin/run-data$i.sh
	rm ../bin/run-data$i.sh.temp1
	rm ../bin/run-data$i.sh.temp2
	rm ../bin/run-data$i.sh.temp3
done

chmod +x ../bin/*.sh
