# 按顺序执行下边命令

# build docker images
* ./basic/build.sh
* ./ssh/build.sh
* ./zoo/build.sh
* ./postgres/build.sh
* ./hadoop/build.sh

# run docker container
* ./bin/run-zoo1.sh
* ./bin/run-zoo2.sh
* ./bin/run-zoo3.sh
* ./bin/run-postgres.sh
* ./bin/run-journal.sh
* ./bin/run-name1.sh
* ./bin/run-name2.sh
* ./bin/run-hbase1.sh
* ./bin/run-hbase2.sh
* ./bin/run-hive1.sh
* ./bin/run-hive2.sh
* ./bin/run-spark1.sh
* ./bin/run-spark2.sh
* ./bin/run-data1.sh
* ./bin/run-data2.sh
* ./bin/run-data3.sh

# startup zookeeper
* root@zoo1:~# ./run.sh
* root@zoo2:~# ./run.sh
* root@zoo3:~# ./run.sh

# setup hive metastore use postgres
* root@postgres:~# /etc/init.d/postgresql start
* root@postgres:~# su - postgres
* postgres@postgres:~# sed "s|#listen_addresses = 'localhost'|listen_addresses = '*'|g" /etc/postgresql/9.5/main/postgresql.conf > /etc/postgresql/9.5/main/postgresql.conf.temp1
* postgres@postgres:~# mv /etc/postgresql/9.5/main/postgresql.conf.temp1 /etc/postgresql/9.5/main/postgresql.conf
* postgres@postgres:~# echo "host all all 172.17.0.0/24 md5" >> /etc/postgresql/9.5/main/pg_hba.conf
* postgres@postgres:~# createuser -P -E -d hive
* postgres@postgres:~# createdb -T template0 -E UTF8 -O hive metastore
* root@postgres:~# /etc/init.d/postgresql restart

# hdfs zkfc format
* root@name1:~# hdfs zkfc -formatZK

# startup journalnode
* root@journal:~# hadoop-daemon.sh start journalnode
* root@name1:~# hadoop-daemon.sh start journalnode
* root@name2:~# hadoop-daemon.sh start journalnode

# startup namenode
* root@name1:~# hdfs namenode -format hdfscluster
* root@name1:~# hadoop-daemon.sh start namenode

# startup standby namenode
* root@name2:~# hdfs namenode -bootstrapStandby
* root@name2:~# hadoop-daemon.sh start namenode

# startup zkfc
* root@name1:~# hadoop-daemon.sh start zkfc
* root@name2:~# hadoop-daemon.sh start zkfc

# 测试 namenode HA
* root@name1:~# hdfs haadmin -getServiceState nn1

# startup datanode
* root@name1:~# hadoop-daemons.sh start datanode

# startup yarn
* root@name1:~# start-yarn.sh

# startup resourcemanager
* root@name2:~# yarn-daemon.sh start resourcemanager

# 测试 resourcemanager HA
* root@name1:~# yarn rmadmin -getServiceState rm1

# startup hbase
* root@hbase1:~# start-hbase.sh

# init hive metastore
* root@hive1:~# schematool -dbType postgres -initSchema

# startup hiveserver2: Starting Web UI on port 10002
* root@hive1:~# hiveserver2 &
* root@hive2:~# hiveserver2 &

# 测试 hiveserver2 HA 方式连接
* root@journal:~# beeline -u "jdbc:hive2://zoo1.hadoop:2181,zoo2.hadoop:2181,zoo3.hadoop:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2" hive "hive"

# shutdown hiveserver2
* root@hive1:~# ps -ef|grep RunJar|awk {'print $2'}|xargs kill -9
* root@hive2:~# ps -ef|grep RunJar|awk {'print $2'}|xargs kill -9

# startup hive metastore
* root@hive1:~# hive --service metastore &
* root@hive2:~# hive --service metastore &

# startup spark
* root@name1:~# hadoop fs -mkdir -p /spark/event/logs
* root@name1:~# hadoop fs -mkdir -p /spark/history/logs
* root@spark1:~# start-master.sh
* root@spark2:~# start-master.sh
* root@spark1:~# start-slaves.sh
* root@spark1:~# start-thriftserver.sh
* root@spark1:~# start-history-server.sh

# 测试 thriftserver
* root@journal:~# beeline -u "jdbc:hive2://spark1.hadoop:10000"

# hdfs
* root@journal:~# hadoop dfs -ls /

# web 界面
* http://127.0.0.1:50070
* http://127.0.0.1:8088
* http://127.0.0.1:16010
* http://127.0.0.1:8080
* http://127.0.0.1:4040
* http://127.0.0.1:18080
* http://127.0.0.1:8081


# 参考资料
* https://my.oschina.net/u/204498/blog/639986
* http://blog.csdn.net/carl810224/article/details/52174412
* http://abloz.com/hbase/book.html
* http://www.tuicool.com/articles/iUBJJj3
* http://www.powerxing.com/install-hadoop-cluster/
