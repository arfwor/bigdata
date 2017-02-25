#!/usr/bin/env bash

XHOME=$(cd "$(dirname "$0")"; pwd)

cd $XHOME

. "$XHOME"/../config/setenv.sh

rm -rf soft
mkdir soft
#cp $SOFT_DIR/jdk-8u112-linux-x64.tar.gz soft
cp $SOFT_DIR/hadoop-$HADOOP_VERSION.tar.gz soft

sed 's/$HADOOP_VERSION/'$HADOOP_VERSION'/g' Dockerfile.template > Dockerfile
docker build -t "hadoop:latest" .

mkdir ../bin

sed 's/$HID/journal/g' run.sh.template > ../bin/run-journal.sh.temp1
sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-journal.sh.temp1 > ../bin/run-journal.sh.temp2
sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-journal.sh.temp2 > ../bin/run-journal.sh
rm ../bin/run-journal.sh.temp1
rm ../bin/run-journal.sh.temp2

for ((i = 1; i < 3; i++));
do
	sed 's/$HID/name'$i'/g' run.sh.template > ../bin/run-name$i.sh.temp1
	sed 's/-p "$NN'$i'_PORT":"$NN'$i'_PORT"/-p 50070:50070/g' ../bin/run-name$i.sh.temp1 > ../bin/run-name$i.sh.temp2
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-name$i.sh.temp2 > ../bin/run-name$i.sh.temp3
	sed 's/-p "$RN'$i'_PORT":"$RN'$i'_PORT"/-p 8088:8088/g' ../bin/run-name$i.sh.temp3 > ../bin/run-name$i.sh.temp4
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-name$i.sh.temp4 > ../bin/run-name$i.sh
	rm ../bin/run-name$i.sh.temp1
	rm ../bin/run-name$i.sh.temp2
	rm ../bin/run-name$i.sh.temp3
	rm ../bin/run-name$i.sh.temp4
done

for ((i = 1; i < 4; i++));
do
	sed 's/$HID/data'$i'/g' run.sh.template > ../bin/run-data$i.sh.temp1
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-data$i.sh.temp1 > ../bin/run-data$i.sh.temp2
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-data$i.sh.temp2 > ../bin/run-data$i.sh
	rm ../bin/run-data$i.sh.temp1
	rm ../bin/run-data$i.sh.temp2
done

chmod +x ../bin/*.sh

rm Dockerfile
rm -rf soft
