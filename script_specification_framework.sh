#!/bin/bash

# Version:1.0.0
# Function: Get the boot process memory consumption based on five boot jar tests
# Use: the script is used mode Script execution locally ,opt as follow:
#       sh time_get_mem.sh
#Date: 2020/04/14
# History:
#   <version>    <time>    <author>        <desc>
#    1.0.0       20/04/14   jack     	Get process memory, YGC, FGC, and generate test data automatically

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
function function01()
{
	#start
}
#Mainly used to get JAVA memory and GC information
function function02()
{
	#start
}

function main()
{
	function01
	function02
}

#main
logfile="/tmp/_auto_pressure_jedis.log"
#variable
variable=""
log "################################## Start ########################################"
# start main function
if [ $? -ne 0 ];then
	log "---ERROR--- Circular execution exception, please check and try again!"
	quit 6
else
	mv ${testfile} `date "+%Y%m%d%H%M%S"`_${testfile}
fi
log "################################## End ########################################"
quit 0