#!/bin/bash

# Get System's Core
CORE=$(lscpu | awk -F ':' 'NR==4 {print $2}' | column -t)

# Set Alert Threshold -> core * 2
THRESHOLD=$(expr $CORE*0.7 | bc)

# Load Average 1 minute
CPU_LOAD=$(top -b -n 1 | head -n 1 | awk '{gsub(",",""); print $(NF-2)}')

# True: 1, False: 0
RESULT=$(echo "$CPU_LOAD > $THRESHOLD" | bc)
if [ $RESULT -eq 1 ]
then
{
  /usr/bin/echo "$(date '+%Y-%m-%d %H:%M:%S') CPU 부하 경고 발생. CPU 부하: $CPU_LOAD, 임계치: $THRESHOLD"
  /bin/bash ./slack.sh "CPU 사용량" "CPU 사용량이 70% 이상입니다. \n CPU 부하: $CPU_LOAD, 임계치: $THRESHOLD" > /dev/null 2>&1
} >> "$(date +%Y-%m-%d)_log.txt"
else
{
  /usr/bin/echo "$(date '+%Y-%m-%d %H:%M:%S') ok"
} >> "$(date +%Y-%m-%d)_log.txt"
fi
