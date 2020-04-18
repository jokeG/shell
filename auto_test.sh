#!/bin/bash

# Version:1.0.0
# Function: Get the boot process memory consumption based on five boot jar tests
# Use: the script is used mode Script execution locally ,opt as follow:
#       sh time_get_mem.sh
#Date: 2020/04/14
# History:
#   <version>    <time>    <author>        <desc>
#    1.0.0       20/04/14   shaoshuai     	定时获取进程内存,YGC,FGC,并自动生成测试数据
###################################################################
#return code
# 0 : ok
# 3 : jar package doesn't exist
# 4 : java progress kill fail
# 5 : init timeout
# 6 : Circular execution exception, please check and try again!
###################################################################

#log function
function log()
{
    echo "`date "+%Y-%m-%d %H:%M:%S"`"  $@ 2>&1 >> $logfile
}

#exit function
function quit()
{
    case $1 in
    0)
        exit 0
    ;;
    3)
		echo "jar package doesn't exist" >&2
        exit 3
    ;;
    4)
		echo "java progress kill fail" >&2
        exit 4
    ;;
    5)
		echo "init timeout" >&2
        exit 5
    ;;
    6)
		echo "Circular execution exception, please check and try again!" >&2
        exit 6
    ;;
    esac
}
#Inspection before pressure test
function checkBeforepressure()
{
	log "start check jar package"
	#1)check jar package default store in /tmp
	if [ ! -f $package ] ; then
		log "---ERROR--- $package doesn't exist"
		quit 3
	else
		log "jar package exist:$package"
	fi
	log "start check&kill java"
	#2)java process checking&kill
	java_pid=`ps -ef|grep java|grep -v grep|awk '{print $2}'|sed -e 's/\r//g'`
	if [ -z "$java_pid" ]; then
		log " java progress doesn't exist,please go on !"
	else
		#kill failed to support retry 1 times
		log "java progress exist:$java_pid,start kill"
		kill -9 ${java_pid}
		if [ $? -eq 0 ];then
			log " java progress kill success"
		else
			java_pid=`ps -ef|grep java|grep -v grep|awk '{print $2}'|sed -e 's/\r//g'`
			kill -9 ${java_pid}
			if [ $? -ne 0 ]; then
				log "---ERROR--- java progress kill fail ,it is twice,please java progress check !"
				quit 4
			fi
		fi
	fi
	#3)delete nohup.out file
	if [ -f ${nohup} ]; then
		rm -rf ${nohupfile}
		log "delete nohup.out"
	fi
	#4)check pressure_measurement_file.txt file
	if [ ! -f ${testfile} ]; then
		touch ${testfile}
		log "touch ${testfile}"
	fi	
}
#Mainly used to get JAVA memory and GC information
function getInformation()
{
	while read line
	do
		log "start java progress"
		nohup $line &
		sleep 2
		#Initialization, timeout 1 minute
		for((m=0; m<60; m++))
		{
			#Use keywords to check the initial situation "Pool check timer"
			log "get the initialization status"
			if [ ${m} -lt 60 ];then
				log "retry to get the initialization keyword times:[$m]"
				ret=`grep "Pool check timer" ${nohupfile}`
					if [ -z "$ret" ];then
						log "in the initialization"
						sleep 1
						continue
					else
						log "the initialization success"
						#get java process memory
						log "get java process memory"
						java_VmRss_MB=`ps aux | grep --color=auto java | grep --color=auto -v grep | awk -F " " '{ sum += $6 } END { printf "java_VmRss_MB:%.2f",sum/1024}'`
						#get java gc infomation : ygc,fgc
						log "get java gc infomation : ygc,fgc"
						java_pid=`ps -ef|grep java|grep -v grep|awk '{print $2}'|sed -e 's/\r//g'`
						log "`jstat -gc $java_pid`"
						YGC=`jstat -gc ${java_pid}|awk 'NR==2 {print $13}'`
						FGC=`jstat -gc ${java_pid}|awk 'NR==2 {print $15}'`
						echo -e "[${n}] `date "+%Y-%m-%d %H:%M:%S"` java_pid:${java_pid},${java_VmRss_MB},YGC:${YGC},FGC:${FGC}" >> $testfile
						log "[${n}] `date "+%Y-%m-%d %H:%M:%S"` ${line}"
						log "[${n}] `date "+%Y-%m-%d %H:%M:%S"` java_pid:${java_pid},${java_VmRss_MB},YGC:${YGC},FGC:${FGC}"
						#delete  nohup.out
						log "delete ${nohupfile}"
						rm -rf ${nohupfile}
						#kill java progress
						log "start kill java progress"
						kill -9 ${java_pid}
						if [ $? -eq 0 ];then
							log " java progress kill success"
						else
							java_pid=`ps -ef|grep java|grep -v grep|awk '{print $2}'`
							kill -9 "$java_pid"
							if [ $? -ne 0 ]; then
								log "---ERROR--- java progress kill fail ,it is twice,please java progress check !"
								quit 4
							fi
						fi
						break
					fi
			else
				log "---ERROR--- the initialization is timeout"
				quit 5
				break
			fi
		}
	done < ${pressure_cmd}
}

function main()
{
	checkBeforepressure
	getInformation
}

#main
packagename="jar包名"
logfile="/tmp/_auto_pressure_jedis.log"
package="/tmp/$packagename.jar"
testfile="pressure_measurement_file.txt"
nohupfile="nohup.out"
pressure_cmd="pressure_cmd"

log "################################## Start ########################################"
#Loop m times, you can specify the execution value
for((n=1; n<6; n++))
{
	if [ ${n} -lt 6 ];then
		main
		if [ $? -ne 0 ];then
			log "---ERROR--- Circular execution exception, please check and try again!"
			quit 6
			break
		else
			log "Loop is running normally, please continue:[${n}]"
			continue
		fi
	fi
}
if [ $? -ne 0 ];then
	log "---ERROR--- Circular execution exception, please check and try again!"
	quit 6
else
	mv ${testfile} `date "+%Y%m%d%H%M%S"`_${testfile}
fi
log "################################## End ########################################"
quit 0
