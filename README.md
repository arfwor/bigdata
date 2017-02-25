https://my.oschina.net/u/204498/blog/639986
http://www.tuicool.com/articles/iUBJJj3
http://www.powerxing.com/install-hadoop-cluster/
http://tech.meituan.com/spark-tuning-basic.html

sh basic/build.sh
sh ssh/build.sh
sh zookeeper/build.sh
sh hadoop/build.sh

sh bin/run-zoo1.sh -> sh /root/run.sh
sh bin/run-zoo2.sh -> sh /root/run.sh
sh bin/run-zoo3.sh -> sh /root/run.sh

sh bin/run-journal.sh
sh bin/run-name1.sh
sh bin/run-name2.sh
sh bin/run-data1.sh
sh bin/run-data2.sh
sh bin/run-data3.sh

name1.hadoop -> hdfs zkfc -formatZK

journal.hadoop -> hadoop-daemon.sh start journalnode
name1.hadoop -> hadoop-daemon.sh start journalnode
name2.hadoop -> hadoop-daemon.sh start journalnode

name1.hadoop -> hdfs namenode -format hdfscluster
name1.hadoop -> hadoop-daemon.sh start namenode

name2.hadoop - > hdfs namenode -bootstrapStandby
name2.hadoop - > hadoop-daemon.sh start namenode

name1.hadoop -> hadoop-daemon.sh start zkfc
name2.hadoop -> hadoop-daemon.sh start zkfc

name1.hadoop -> hdfs haadmin -getServiceState nn1

name1.hadoop -> ssh journal.hadoop && ssh name2.hadoop && ssh data1.hadoop && ssh data2.hadoop && ssh data3.hadoop

name2.hadoop -> ssh journal.hadoop && ssh name1.hadoop && ssh data1.hadoop && ssh data2.hadoop && ssh data3.hadoop

name1.hadoop -> hadoop-daemons.sh start datanode

name1.hadoop -> start-yarn.sh

name2.hadoop -> yarn-daemon.sh start resourcemanager

name1.hadoop -> yarn rmadmin -getServiceState rm1

http://127.0.0.1:50070
http://127.0.0.1:8088