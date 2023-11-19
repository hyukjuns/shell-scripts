#!/bin/bash

# megabytes
AVAILABLE_MEM=$(free -m | awk 'NR==2 {print $4}')
THRESHOLD=1024

# Check condition 
if [ $AVAILABLE_MEM -lt $THRESHOLD ]
then
{
        /bin/echo "$(date '+%Y-%m-%d %H:%M:%S'), Warn 현재 가용 메모리: $AVAILABLE_MEM"
        /bin/bash ./slack.sh "Memory" "Warn: 가용 메모리가 부족합니다. 현재 가용 메모리: $AVAILABLE_MEM" > /dev/null 2>&1
} >> "$(date '+%Y-%m-%d')_mem_log.txt"
else
{
        /bin/echo "$(date '+%Y-%m-%d %H:%M'), Ok, 현재 가용 메모리: $AVAILABLE_MEM"
} >> "$(date '+%Y-%m-%d')_mem_log.txt"
fi