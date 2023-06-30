#!/bin/bash
#set -eoux pipefail

# CPU 부하 체크
## 코어개수, Load Average 계산

# 코어개수
CORE=$(lscpu | awk -F ':' 'NR==4 {print $2}' | column -t)
# 임계치 70%, core * 0.7
THRESHOLD=$(expr $CORE*0.7 | bc)
# CPU 부하, 1분 평균 값
CPU_LOAD=$(top -b -n 1 | head -n 1 | awk '{gsub(",",""); print $10}')

# 만약 현재 CPU 부하가 임계치보다 높을 경우 알람 발생
## 참 = 1, 거짓 = 0
RES=$(echo "$CPU_LOAD > $THRESHOLD" | bc)
if [ $RES -eq 1 ]
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
