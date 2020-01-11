#!/bin/sh
su - hdfs
cd  /var/run/cloudera-scm-agent/process/
path=/var/run/cloudera-scm-agent/process/
cd $path
ls -d *DATANODE* > /tmp/test.txt
var=`tail -n 1 /tmp/test.txt`
echo $var
#1212-hdfs-DATANODE
cd $var
#/var/run/cloudera-scm-agent/process/1212-hdfs-DATANODE
ls -l hdfs.keytab
klist -kte $path/$var/hdfs.keytab
klist -k $path/$var/hdfs.keytab
klist -k  $path/$var/hdfs.keytab > /tmp/test1.txt
klist -k  $path/$var/hdfs.keytab | grep hdfs >/tmp/test1.txt
tail -n 1 /tmp/test1.txt > /tmp/test2.txt
awk '{ print $NF }' /tmp/test2.txt
var1=`awk '{ print $NF }' /tmp/test2.txt`
echo $var
kinit -kt ./hdfs.keytab $var1
klist -ef

/bin/su - hdfs -c "kdestroy"
path=/var/run/cloudera-scm-agent/process/
cd $path
ls -d *hdfs-NAMENODE > /tmp/test.txt
var=`tail -n 1 /tmp/test.txt`
echo $var
#1212-hdfs-DATANODE
cd $var
#/var/run/cloudera-scm-agent/process/1212-hdfs-DATANODE
ls -l hdfs.keytab
klist -kte ./hdfs.keytab
klist -k $path/$var/hdfs.keytab
klist -k  $path/$var/hdfs.keytab > /tmp/test1.txt
klist -k  $path/$var/hdfs.keytab | grep hdfs >/tmp/test1.txt
tail -n 1 /tmp/test1.txt > /tmp/test2.txt
awk '{ print $NF }' /tmp/test2.txt
var1=`awk '{ print $NF }' /tmp/test2.txt`
echo $var1
echo $path
echo $var
kinit -kt $path/$var/hdfs.keytab $var1
/bin/su - hdfs -c "kinit -kt $path/$var/hdfs.keytab $var1"
/bin/su - hdfs -c "klist -ef"
exit
