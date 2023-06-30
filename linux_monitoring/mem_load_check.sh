#!/bin/bash
#set -eoux pipefail

# Mem 부하 체크
## 가용메모리 (free)가 1GB 이하일 경우 경고 알람 발생

# megabytes
AVAILABLE_MEM=$(free -m | awk 'NR==2 {print $4}')
THRESHOLD=1024

# 임계치보다 높으면 경고 알람 발생
# 점검  로그 기록
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