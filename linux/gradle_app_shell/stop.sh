#!/bin/bash
SAVED=$(pwd)
cd "$(dirname $0)"
BINPATH=$(pwd -P)
. $BINPATH/param.sh
cd $SAVED
ps -ef|grep java|grep $APP_NAME|grep -v grep|awk '{print $2}'|xargs kill -9
