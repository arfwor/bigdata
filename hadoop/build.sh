#!/usr/bin/env bash

XHOME=$(cd "$(dirname "$0")"; pwd)

cd $XHOME

. "$XHOME"/../conf/setenv.sh

rm -rf soft
mkdir soft
#cp $SOFT_DIR/jdk-8u112-linux-x64.tar.gz soft
cp $SOFT_DIR/hadoop-$HADOOP_VERSION.tar.gz soft
cp $SOFT_DIR/hbase-$HBASE_VERSION-bin.tar.gz soft
cp $SOFT_DIR/apache-hive-$HIVE_VERSION-bin.tar.gz soft
cp $SOFT_DIR/postgresql-9.4.1212.jar soft
# wget http://central.maven.org/maven2/org/postgresql/postgresql/9.4.1212/postgresql-9.4.1212.jar -O soft/postgresql-9.4.1212.jar
cp $SOFT_DIR/spark-$SPARK_VERSION-bin-hadoop2.7.tgz soft

sed 's/$HADOOP_VERSION/'$HADOOP_VERSION'/g' Dockerfile.template > Dockerfile.temp1
sed 's/$HBASE_VERSION/'$HBASE_VERSION'/g' Dockerfile.temp1 > Dockerfile.temp2
sed 's/$HIVE_VERSION/'$HIVE_VERSION'/g' Dockerfile.temp2 > Dockerfile.temp3
sed 's/$SPARK_VERSION/'$SPARK_VERSION'/g' Dockerfile.temp3 > Dockerfile
docker build -t "main-hadoop:latest" .
rm Dockerfile.temp1
rm Dockerfile.temp2
rm Dockerfile.temp3
rm Dockerfile

rm -rf soft

mkdir ../bin

sed 's/$HID/journal/g' run.sh.template > ../bin/run-journal.sh.temp1
sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-journal.sh.temp1 > ../bin/run-journal.sh.temp2
sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-journal.sh.temp2 > ../bin/run-journal.sh.temp3
sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-journal.sh.temp3 > ../bin/run-journal.sh.temp4
sed 's/-p "$SM1_PORT":"$SM1_PORT"//g' ../bin/run-journal.sh.temp4 > ../bin/run-journal.sh.temp5
sed 's/-p "$ST1_PORT":"$ST1_PORT"//g' ../bin/run-journal.sh.temp5 > ../bin/run-journal.sh.temp6
sed 's/-p "$SW1_PORT":"$SW1_PORT"//g' ../bin/run-journal.sh.temp6 > ../bin/run-journal.sh.temp7
sed 's/-p "$SH1_PORT":"$SH1_PORT"//g' ../bin/run-journal.sh.temp7 > ../bin/run-journal.sh
rm ../bin/run-journal.sh.temp1
rm ../bin/run-journal.sh.temp2
rm ../bin/run-journal.sh.temp3
rm ../bin/run-journal.sh.temp4
rm ../bin/run-journal.sh.temp5
rm ../bin/run-journal.sh.temp6
rm ../bin/run-journal.sh.temp7

for ((i = 1; i < 3; i++));
do
	sed 's/$HID/name'$i'/g' run.sh.template > ../bin/run-name$i.sh.temp1
	sed 's/-p "$NN'$i'_PORT":"$NN'$i'_PORT"/-p 50070:50070/g' ../bin/run-name$i.sh.temp1 > ../bin/run-name$i.sh.temp2
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-name$i.sh.temp2 > ../bin/run-name$i.sh.temp3
	sed 's/-p "$RN'$i'_PORT":"$RN'$i'_PORT"/-p 8088:8088/g' ../bin/run-name$i.sh.temp3 > ../bin/run-name$i.sh.temp4
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-name$i.sh.temp4 > ../bin/run-name$i.sh.temp5
	sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-name$i.sh.temp5 > ../bin/run-name$i.sh.temp6
	sed 's/-p "$SM1_PORT":"$SM1_PORT"//g' ../bin/run-name$i.sh.temp6 > ../bin/run-name$i.sh.temp7
	sed 's/-p "$ST1_PORT":"$ST1_PORT"//g' ../bin/run-name$i.sh.temp7 > ../bin/run-name$i.sh.temp8
	sed 's/-p "$SW1_PORT":"$SW1_PORT"//g' ../bin/run-name$i.sh.temp8 > ../bin/run-name$i.sh.temp9
	sed 's/-p "$SH1_PORT":"$SH1_PORT"//g' ../bin/run-name$i.sh.temp9 > ../bin/run-name$i.sh
	rm ../bin/run-name$i.sh.temp1
	rm ../bin/run-name$i.sh.temp2
	rm ../bin/run-name$i.sh.temp3
	rm ../bin/run-name$i.sh.temp4
	rm ../bin/run-name$i.sh.temp5
	rm ../bin/run-name$i.sh.temp6
	rm ../bin/run-name$i.sh.temp7
	rm ../bin/run-name$i.sh.temp8
	rm ../bin/run-name$i.sh.temp9
done

for ((i = 1; i < 3; i++));
do
	sed 's/$HID/hbase'$i'/g' run.sh.template > ../bin/run-hbase$i.sh.temp1
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-hbase$i.sh.temp1 > ../bin/run-hbase$i.sh.temp2
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-hbase$i.sh.temp2 > ../bin/run-hbase$i.sh.temp3
	sed 's/-p "$HM'$i'_PORT":"$HM'$i'_PORT"/-p 16010:16010/g' ../bin/run-hbase$i.sh.temp3 > ../bin/run-hbase$i.sh.temp4
	sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-hbase$i.sh.temp4 > ../bin/run-hbase$i.sh.temp5
	sed 's/-p "$SM1_PORT":"$SM1_PORT"//g' ../bin/run-hbase$i.sh.temp5 > ../bin/run-hbase$i.sh.temp6
	sed 's/-p "$ST1_PORT":"$ST1_PORT"//g' ../bin/run-hbase$i.sh.temp6 > ../bin/run-hbase$i.sh.temp7
	sed 's/-p "$SW1_PORT":"$SW1_PORT"//g' ../bin/run-hbase$i.sh.temp7 > ../bin/run-hbase$i.sh.temp8
	sed 's/-p "$SH1_PORT":"$SH1_PORT"//g' ../bin/run-hbase$i.sh.temp8 > ../bin/run-hbase$i.sh
	rm ../bin/run-hbase$i.sh.temp1
	rm ../bin/run-hbase$i.sh.temp2
	rm ../bin/run-hbase$i.sh.temp3
	rm ../bin/run-hbase$i.sh.temp4
	rm ../bin/run-hbase$i.sh.temp5
	rm ../bin/run-hbase$i.sh.temp6
	rm ../bin/run-hbase$i.sh.temp7
	rm ../bin/run-hbase$i.sh.temp8
done

for ((i = 1; i < 3; i++));
do
	sed 's/$HID/hive'$i'/g' run.sh.template > ../bin/run-hive$i.sh.temp1
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-hive$i.sh.temp1 > ../bin/run-hive$i.sh.temp2
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-hive$i.sh.temp2 > ../bin/run-hive$i.sh.temp3
	sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-hive$i.sh.temp3 > ../bin/run-hive$i.sh.temp4
	sed 's/-p "$SM1_PORT":"$SM1_PORT"//g' ../bin/run-hive$i.sh.temp4 > ../bin/run-hive$i.sh.temp5
	sed 's/-p "$ST1_PORT":"$ST1_PORT"//g' ../bin/run-hive$i.sh.temp5 > ../bin/run-hive$i.sh.temp6
	sed 's/-p "$SW1_PORT":"$SW1_PORT"//g' ../bin/run-hive$i.sh.temp6 > ../bin/run-hive$i.sh.temp7
	sed 's/-p "$SH1_PORT":"$SH1_PORT"//g' ../bin/run-hive$i.sh.temp7 > ../bin/run-hive$i.sh
	rm ../bin/run-hive$i.sh.temp1
	rm ../bin/run-hive$i.sh.temp2
	rm ../bin/run-hive$i.sh.temp3
	rm ../bin/run-hive$i.sh.temp4
	rm ../bin/run-hive$i.sh.temp5
	rm ../bin/run-hive$i.sh.temp6
	rm ../bin/run-hive$i.sh.temp7
done

for ((i = 1; i < 3; i++));
do
	sed 's/$HID/spark'$i'/g' run.sh.template > ../bin/run-spark$i.sh.temp1
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-spark$i.sh.temp1 > ../bin/run-spark$i.sh.temp2
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-spark$i.sh.temp2 > ../bin/run-spark$i.sh.temp3
	sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-spark$i.sh.temp3 > ../bin/run-spark$i.sh.temp4
	sed 's/-p "$SM'$i'_PORT":"$SM'$i'_PORT"/-p 8080:8080/g' ../bin/run-spark$i.sh.temp4 > ../bin/run-spark$i.sh.temp5
	sed 's/-p "$SM1_PORT":"$SM1_PORT"//g' ../bin/run-spark$i.sh.temp5 > ../bin/run-spark$i.sh.temp6
	sed 's/-p "$ST'$i'_PORT":"$ST'$i'_PORT"/-p 4040:4040/g' ../bin/run-spark$i.sh.temp6 > ../bin/run-spark$i.sh.temp7
	sed 's/-p "$ST1_PORT":"$ST1_PORT"//g' ../bin/run-spark$i.sh.temp7 > ../bin/run-spark$i.sh.temp8
	sed 's/-p "$SW1_PORT":"$SW1_PORT"//g' ../bin/run-spark$i.sh.temp8 > ../bin/run-spark$i.sh.temp9
	sed 's/-p "$SH'$i'_PORT":"$SH'$i'_PORT"/-p 18080:18080/g' ../bin/run-spark$i.sh.temp9 > ../bin/run-spark$i.sh.temp10
	sed 's/-p "$SH1_PORT":"$SH1_PORT"//g' ../bin/run-spark$i.sh.temp10 > ../bin/run-spark$i.sh
	rm ../bin/run-spark$i.sh.temp1
	rm ../bin/run-spark$i.sh.temp2
	rm ../bin/run-spark$i.sh.temp3
	rm ../bin/run-spark$i.sh.temp4
	rm ../bin/run-spark$i.sh.temp5
	rm ../bin/run-spark$i.sh.temp6
	rm ../bin/run-spark$i.sh.temp7
	rm ../bin/run-spark$i.sh.temp8
	rm ../bin/run-spark$i.sh.temp9
	rm ../bin/run-spark$i.sh.temp10
done

for ((i = 1; i < 4; i++));
do
	sed 's/$HID/data'$i'/g' run.sh.template > ../bin/run-data$i.sh.temp1
	sed 's/-p "$NN1_PORT":"$NN1_PORT"//g' ../bin/run-data$i.sh.temp1 > ../bin/run-data$i.sh.temp2
	sed 's/-p "$RN1_PORT":"$RN1_PORT"//g' ../bin/run-data$i.sh.temp2 > ../bin/run-data$i.sh.temp3
	sed 's/-p "$HM1_PORT":"$HM1_PORT"//g' ../bin/run-data$i.sh.temp3 > ../bin/run-data$i.sh.temp4
	sed 's/-p "$SM1_PORT":"$SM1_PORT"//g' ../bin/run-data$i.sh.temp4 > ../bin/run-data$i.sh.temp5
	sed 's/-p "$ST1_PORT":"$ST1_PORT"//g' ../bin/run-data$i.sh.temp5 > ../bin/run-data$i.sh.temp6
	sed 's/-p "$SW'$i'_PORT":"$SW'$i'_PORT"/-p 8081:8081/g' ../bin/run-data$i.sh.temp6 > ../bin/run-data$i.sh.temp7
	sed 's/-p "$SW1_PORT":"$SW1_PORT"//g' ../bin/run-data$i.sh.temp7 > ../bin/run-data$i.sh.temp8
	sed 's/-p "$SH1_PORT":"$SH1_PORT"//g' ../bin/run-data$i.sh.temp8 > ../bin/run-data$i.sh
	rm ../bin/run-data$i.sh.temp1
	rm ../bin/run-data$i.sh.temp2
	rm ../bin/run-data$i.sh.temp3
	rm ../bin/run-data$i.sh.temp4
	rm ../bin/run-data$i.sh.temp5
	rm ../bin/run-data$i.sh.temp6
	rm ../bin/run-data$i.sh.temp7
	rm ../bin/run-data$i.sh.temp8
done

chmod +x ../bin/*.sh
