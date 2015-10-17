#应用启动参数配置

#实际启动脚本名称（由gradle得application插件生成）
export scriptname=edumgmt
#应用的名称，用于唯一搜索进程ID使用
export APP_NAME=InfoMgmtApplication
export JAVA_OPTS="-server -Xms256M -Xmx512M -D$APP_NAME"
#项目部署所在目录，为绝对路径
export APP_HOME=/home/javateam/edumgmt
#由gradle打包生成的jar包名字
export jarfile=edumgmt.jar
