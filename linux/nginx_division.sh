#!/bin/bash
#设置日志文件存放目录
logs_path="/usr/local/nginx/logs/"
#冷备份日志目录
dist_path="/hdfs/data01/nginx/logs/"
#设置pid文件
pid_path="/usr/local/nginx/logs/nginx.pid"
#日志文件
file_path=${logs_path}"log.access.log"
# Source function library.
#重命名日志文件
mv ${file_path} ${dist_path}mob_$(date -d '-1 hour' +%Y-%m-%d-%H).log -f --backup=numbered
#向nginx主进程发信号重新打开日志
kill -USR1 `cat ${pid_path}`

backup_path=/hdfs/data01/nginx/backup/
dataStrH=`date -d '-1 hour' +%H`
dataStrD=`date -d '-1 day' +%Y-%m-%d`
if [ "${dataStrH}" = "12" ];then
	mkdir -p ${backup_path}${dataStrD}
        mv ${dist_path}mob_${dataStrD}* ${backup_path}${dataStrD}
fi
