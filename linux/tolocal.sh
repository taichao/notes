#/bin/bash
#by zhangtaichao
#connect to Anywhere
function tips() {
	echo "
		******************************
		*                            *
		*    connect to Anywhere!    *
		*        by ztc              *
		*                            *
		******************************
		"
}
tips
local=~/ztcbin/local.txt
awk '
BEGIN {
	echo "Please input your choice"
}
{
	printf "%-2s)-->%s\n",FNR,$0
}
' $local
if [ -z $1 ]; then
    read input
else
    input=$1
fi

if [[ "$input" = "q" || "$input" = "Q" ]];then
exit
fi
host=`awk -F, -v input=$input '
{
	if(FNR==input) {
		print $0
	}
}
' $local`
if test -z $host;then
echo "your select is error,Bye Bye!"
else 

echo "Your select is "$host
cd $host
fi
