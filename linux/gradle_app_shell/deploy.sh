#!/bin/bash
SAVED=$(pwd)
cd "$(dirname $0)"
BINPATH=$(pwd -P)
. $BINPATH/param.sh
cd $SAVED

export DATESTR=`date +%Y%m%d`
export BAK=$jarfile.$DATESTR

BAKFILE=$APP_HOME/lib/$BAK
OLDFILE=$APP_HOME/lib/$jarfile 
NEWFILE=$APP_HOME/deploy/$jarfile
if [ -f $NEWFILE ]; then
	echo "stop application"
	sh $APP_HOME/bin/stop.sh
	echo "bakup $OLDFILE to $BAKFILE"
	mv $OLDFILE $BAKFILE
	echo "copy $NEWFILE to $OLDFILE"
	cp $NEWFILE $OLDFILE
	sh $APP_HOME/bin/start.sh
else
	echo "newfile $NEWFILE not exists"
	echo "i will do nothing"
fi
