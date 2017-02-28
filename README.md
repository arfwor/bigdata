https://my.oschina.net/u/204498/blog/639986
http://blog.csdn.net/carl810224/article/details/52174412
http://abloz.com/hbase/book.html
http://www.tuicool.com/articles/iUBJJj3
http://www.powerxing.com/install-hadoop-cluster/


./basic/build.sh
./ssh/build.sh
./zoo/build.sh
./hadoop/build.sh

./bin/run-zoo1.sh -> sh /root/run.sh
./bin/run-zoo2.sh -> sh /root/run.sh
./bin/run-zoo3.sh -> sh /root/run.sh

./bin/run-journal.sh
./bin/run-master1.sh
./bin/run-master2.sh
./bin/run-data1.sh
./bin/run-data2.sh
./bin/run-data3.sh

master1.hadoop -> hdfs zkfc -formatZK

journal.hadoop -> hadoop-daemon.sh start journalnode
master1.hadoop -> hadoop-daemon.sh start journalnode
master2.hadoop -> hadoop-daemon.sh start journalnode

master1.hadoop -> hdfs namenode -format hdfscluster
master1.hadoop -> hadoop-daemon.sh start namenode

master2.hadoop - > hdfs namenode -bootstrapStandby
master2.hadoop - > hadoop-daemon.sh start namenode

master1.hadoop -> hadoop-daemon.sh start zkfc
master2.hadoop -> hadoop-daemon.sh start zkfc

master1.hadoop -> hdfs haadmin -getServiceState nn1

master1.hadoop -> ssh master2.hadoop && ssh journal.hadoop && ssh zoo1.zookeeper && ssh zoo2.zookeeper && ssh zoo3.zookeeper && ssh data1.hadoop && ssh data2.hadoop && ssh data3.hadoop
master2.hadoop -> ssh master1.hadoop && ssh journal.hadoop && ssh zoo1.zookeeper && ssh zoo2.zookeeper && ssh zoo3.zookeeper && ssh data1.hadoop && ssh data2.hadoop && ssh data3.hadoop

master1.hadoop -> hadoop-daemons.sh start datanode

master1.hadoop -> start-yarn.sh

master2.hadoop -> yarn-daemon.sh start resourcemanager

master1.hadoop -> yarn rmadmin -getServiceState rm1

master1.hadoop -> start-hbase.sh

http://127.0.0.1:50070
http://127.0.0.1:8088
http://127.0.0.1:16010
