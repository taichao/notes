#!/bin/bash
SAVED=$(pwd)
cd "$(dirname $0)"
BINPATH=$(pwd -P)
. $BINPATH/param.sh
cd $SAVED
nohup $APP_HOME/bin/$scriptname > /dev/null 2>&1 &
echo "pid is"
ps -ef|grep java|grep $APP_NAME|grep -v grep|awk '{print $2}'|xargs echo
