# Shell Scripts

```bash
# ps 특정 프로세스 선택
ps -fC <COMMAND>
ps -fC nginx
-C cmdlist      Select by command name. This selects the processes whose **executable** name
              is given in cmdlist.
-f              Do full-format listing.

# 산술계산
bc
THRESHOLD=$(expr $CORE*0.7 | bc)

# TOP Hotkey 1 -> cpu 코어별로 출력, d>1, 간격 1초
top

# awk 마지막행 출력
awk'{print $NF}'

# 아웃풋 왼쪽 정렬
column -t

# 커맨드 타임아웃
timeout Ns command

# 현재 ESTABLISHED 인 소켓 카운트
netstat -a | grep ESTABLISHED | wc -l

# 현재 TIME_WAIT 상태인 소켓 카운트
netstat -a | grep TIME_WAIT | wc -l

# 메모리 많이 사용하는 프로세스 top 10
ps aux | sort -nr -k 4 | head -n 10

# 좀비 프로세스 개수
top -b -n1 | head -n 2 | awk 'NR==2 {print $10" zombie found"}'

# IO Interrupt를 기다리고 있는 프로세스 출력
while true; do date; ps auxf | awk '{if($8=="D") print $0;}'; sleep 1;done

# 프로세스별 메모리 사용량만 표기
ps -eo pmem,comm

# 특정 프로세스가 전체 메모리의 몇 펴선테를 사용하는지 출력
ps -eo pmem,comm | grep -i "httpd" | awk '{sum+=$1} END {print sum "% of Memory"}'

# 코어 개수 확인
lscpu | awk -F ':' 'NR==4 {print $2}' | column -t

# 1분간 CPU 사용률
top -b -n 1 | head -n 1 | awk '{gsub(",",""); print $10}'

# tcpdump
tcpdump -i eth0 tcp port 80 -c 100 -w result.pcap

# 1GB 더미 파일 생성
dd if=/dev/zero of=temp_file_1G bs=1024 count=1000000

# 디스크 사용률 90% 이상 찾기
df -h | awk '{gsub("%","");USE=$5; MNT=$6; THRESHOLD=90; if(USE>THRESHOLD) print $5"%", $6}' | grep -v '^[A-Z]'

# 로그 파일 찾기
find /var -name "*.log" -exec ls -al {} \;

# 프로세스 트리구조 확인
ps axjf
```
