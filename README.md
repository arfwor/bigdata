# 参考资料
https://my.oschina.net/u/204498/blog/639986
http://blog.csdn.net/carl810224/article/details/52174412
http://abloz.com/hbase/book.html
http://www.tuicool.com/articles/iUBJJj3
http://www.powerxing.com/install-hadoop-cluster/

# 按顺序执行下边命令

# build docker images
./basic/build.sh
./ssh/build.sh
./zoo/build.sh
./postgres/build.sh
./hadoop/build.sh

# run docker container
./bin/run-zoo1.sh
./bin/run-zoo2.sh
./bin/run-zoo3.sh
./bin/run-postgres.sh
./bin/run-journal.sh
./bin/run-master1.sh
./bin/run-master2.sh
./bin/run-data1.sh
./bin/run-data2.sh
./bin/run-data3.sh

# startup zookeeper
root@zoo1:~# ./run.sh
root@zoo2:~# ./run.sh
root@zoo3:~# ./run.sh

# setup hive metastore use postgres
root@postgres:~# /etc/init.d/postgresql start
root@postgres:~# su - postgres
postgres@postgres:~# sed "s|#listen_addresses = 'localhost'|listen_addresses = '*'|g" /etc/postgresql/9.5/main/postgresql.conf > /etc/postgresql/9.5/main/postgresql.conf.temp1
postgres@postgres:~# mv /etc/postgresql/9.5/main/postgresql.conf.temp1 /etc/postgresql/9.5/main/postgresql.conf
postgres@postgres:~# echo "host all all 172.17.0.0/24 md5" >> /etc/postgresql/9.5/main/pg_hba.conf
postgres@postgres:~# createuser -P -E -d hive
postgres@postgres:~# createdb -T template0 -E UTF8 -O hive metastore
root@postgres:~# /etc/init.d/postgresql restart

root@master1:~# hdfs zkfc -formatZK

root@journal:~# hadoop-daemon.sh start journalnode
root@master1:~# hadoop-daemon.sh start journalnode
root@master2:~# hadoop-daemon.sh start journalnode

root@master1:~# hdfs namenode -format hdfscluster
root@master1:~# hadoop-daemon.sh start namenode

root@master2:~# hdfs namenode -bootstrapStandby
root@master2:~# hadoop-daemon.sh start namenode

root@master1:~# hadoop-daemon.sh start zkfc
root@master2:~# hadoop-daemon.sh start zkfc

# 测试 namenode HA
root@master1:~# hdfs haadmin -getServiceState nn1

# 预先 ssh 一次所有集群
root@master1:~# ssh master2.hadoop && ssh journal.hadoop && ssh zoo1.hadoop && ssh zoo2.hadoop && ssh zoo3.hadoop && ssh data1.hadoop && ssh data2.hadoop && ssh data3.hadoop
root@master2:~# ssh master1.hadoop && ssh journal.hadoop && ssh zoo1.hadoop && ssh zoo2.hadoop && ssh zoo3.hadoop && ssh data1.hadoop && ssh data2.hadoop && ssh data3.hadoop

root@master1:~# hadoop-daemons.sh start datanode

root@master1:~# start-yarn.sh

root@master2:~# yarn-daemon.sh start resourcemanager

# 测试 resourcemanager HA
root@master1:~# yarn rmadmin -getServiceState rm1

root@master1:~# start-hbase.sh

root@master1:~# schematool -dbType postgres -initSchema

root@master1:~# hiveserver2 &
root@master2:~# hiveserver2 &

# 测试 hiveserver2 HA 方式连接
root@journal:~# beeline
!connect jdbc:hive2://zoo1.hadoop:2181,zoo2.hadoop:2181,zoo3.hadoop:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2 hive "hive"


# web 界面
http://127.0.0.1:50070
http://127.0.0.1:8088
http://127.0.0.1:16010

