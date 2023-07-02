### Grammar and Tips

- CPU, top, mpstat, sar, uptime, vmstat
    
    ```bash
    # 부하 상태 확인
    부하상태는 코어 개수에 따라 상대적이므로, 코어 개수를 고려하여 확인 해야 함
    - Load / Core * 100 = CPU Usage
    - 100 - CPU Usage = CPU Idle
    
    # 지표 확인
    top
    	- load average <1m> <5m> <15m> : 1분,5분,15분 별 평균 CPU 부하
    	- us: 사용자사용, sy: 시스템사용, ni: 나이스타임, id: 유휴상태, si: 스왑인
    	- shift + p : CPU 사용률 내림차순
    	- shit + m : 메모리 사용률 내림차순
    	- shift + t : 프로세스가 돌아가고 있는 시간 순
    	- 숫자 1 ⇒ CPU 별 사용량 확인
    vmstat
      - r: 실행되기를 기다리거나, 현재 실행되고 있는 프로세스 개수
      - b: I/O를 위해 대기열에 있는 프로세스 개수
    
    # useful commands
    ## 코어 개수 확인
    lscpu | awk -F ':' 'NR==4 {print $2}' | column -t
    
    ## 1분간 CPU 사용률
    top -b -n 1 | head -n 1 | awk '{gsub(",",""); print $10}'
    ```
    
- Memory, free, vmstat
    
    ```bash
    # COMMANDS
    free, vmstat
    
    # useful commands
    ```
    
- Disk, df, du
    
    ```bash
    # COMMANDS
    df, du
    
    # useful commands
    ```
    
- 편집기설정, vi/vim
    
    ```bash
    # ~/.vimrc
    syntax on # 문법 하이라이팅
    set autoindent # 자동 들여쓰기
    set ts=2 # tabpstop, 탭 간격
    set sw=2 # shiftwidth(making shift operations (<< or >>))
    set et # expandtab, tab 공백을 space 공백으로 전환가능, 즉, tab 공백을 스페이스로 한칸씩 제거 가능
    set nu # line number
    set ruler # 화면 오른쪽 아래에 현재 커서위치 표시
    ```
    
- 파일, 디렉토리 압축, tar
    
    ```bash
    # 압축파일 생성 (gzip)
    tar -czvf <zipfile>.gz [PATH|FILES]
    
    # 압축 풀기
    tar -xzvf <zipfile>.gz # 현재 디레곹리
    tar -xzvf <zipfile>.gz -C [PATH] # 특정 경로에 풀기
    
    # 압축 내용 리스트
    tar -tvf <zipfile>.gz
    ```
    
- 네트워크 패킷 캡쳐, tcpdump
    
    ```bash
    # usage
    tcpdump -i <device> <protocol> <port> -c <count> -v|vv -nn -w resulrt.pcap
    tcpdump -i eth0 tcp port 80 -c 100 -v -nn -w result.pcap
    
    # simple
    tcpdump -i eth0 tcp port 80 -c 100 -w result.pcap
    
    # 쓰기 / 읽기
    tcpdump port 80 -w result.pcap
    tcpdump -r result.pcap
    
    # 패킷 개수 지정 (-c)
    tcpdump -i eth0 tcp port 80 -c 100
    
    # 특정 네트워크카드, 특정 포트, 프로토콜/포트를 숫자로출력(-nn), 자세하게 (-v, -vv)
    tcpdump -i eth0 tcp port 443
    tcpdump -i eth0 -nn -v port 80
    
    # src/dst 필터링
    tcpdump -i eth0 src 192.168.10.11
    tcpdump -i eth0 dst 192.168.10.12
    tcpdump -i eht0 src 192.168.10.11 and dst 192.168.10.12
    tcpdump host 192.168.10.13 # src/dst 모두
    
    # 논리연산(and, or)사용가능
    tcpdump -i eht0 src 192.168.10.11 and dst 192.168.10.12
    tcpdump -i eht0 src 192.168.10.11 or src 192.168.10.12
    ```
    
- 더미파일 생성 ,dd
    
    ```python
    # 1G 더미 파일 생성
    dd if=/dev/zero of=temp_file_1G bs=1G count=1
    dd if=/dev/zero of=temp_file_1G bs=1024 count=1000000
    
    # 더미파일을 0이 아닌 랜덤스트링 데이터로 채우고 싶을경우 /dev/urandom 사용
    
    # if=인풋파일,stdin 대신사용
    # of=아웃풋파일,stdout 대신 사용
    # bs=용량, blocksize, 기본단위: bytes
    # count=반복횟수
    
    # 기타명령어
    fallocate -l 10GB 10G.file # -l: bytes의 길이, 즉 크기
    truncate -s 500MB half-giga.file # -s: block size, 즉 크기
    
    1024 bytes
    = 1 kilo bytes
    *1000 = 1000 kilo bytes = 1 mega bytes
    *1000 = 1000 mega bytes = 1 Giga bytes
    ```
    
- 출력 리다이렉트, >|, >>
    
    ```bash
    # overwrite
    {
      echo test
    } >| log.txt
    
    # append
    {
      echo test
    } >> log.txt
    ```
    
- 문자열 찾기, grep
    
    ```python
    # 매치되지 않는 라인 반환, -v 옵션
    -v, --invert-match        select non-matching lines
    
    # 영어 알파벳 제외
    grep -v '^[A-Z]'
    
    # 숫자 제외
    grep -v '^[1-9]'
    ```
    
- 스트림 편집, awk
    
    ```bash
    # 출력
    awk '{pirnt $1, $2, $3}' sample.txt
    
    # 문자 변환
    awk '{gsub('111', '444'); print $1}' sample.txt
    df -h | awk '{gsub("%",""); print $5}'| sort -nr
    
    # 특정 라인 출력 => NR
    lscpu | awk 'NR==4 {print $2}'
    
    # delimeter => -F
    lscpu | awk -F ':' '{print $2}'
    
    # if문, 변수 사용
    ## awk '{var=$column; if(condition) action}'
    df -h | awk '{gsub("%",""); USE=$5; if(USE>1) print $5}' | grep -v '^[A-Z]'
    
    # AWK IF-Else
    # with multiple actions
    if(conditional-expression1) { 
    	action1_1;
    	action1_2;
    }
    else if(conditional-expression2)
    	action2;
    else if(conditional-expression3)
    	action3;
    	.
    	.
    else
    	action n;
    
    # 3항 연산
    conditional-expression ? action1 : action2 ;
    
    # END
    입력의 모든 라인이 처리되고 난후 다음 명령 실행
    ps -eo pmem,comm | grep -i "httpd" | awk '{sum+=$1} END {print sum "% of Memory"}'
    ```
    
- 스트림 편집, sed
    
    ```bash
    # 내용 교체 및 출력 (라인마다 패턴에 매칭된 첫번째 요소 변경)
    sed ‘s/unix/linux/’ example.txt
    
    # 모든 내용 교체 및 출력 (모든 라인에서 패턴에 매칭된 모든 요소 변경)
    sed ‘s/unix/linux/g’ example.txt
    
    # n번째 라인만 교체 (s 앞에 적용할 라인 넘버 입력)
    sed '3 s/unix/linux/' example.txt
    
    # 적용할 라인에서 패턴에 매칭된 모든 내용 교체
    sed '3 s/unix/linux/g' example.txt
    
    # 변경 및 교체, -i 옵션
    sed -i 's/111/yyy/' sample.txt
    ```
    
- 정령, sort
    
    ```bash
    # sort -nr : 내림차순 정렬 -n: number, -r: reverse
    df -h | awk '{print $5}'| sort -nr
    ```
    
- 열 간격 조정. column
    
    ```bash
    # column -t
    mount | column -t
    ```
    
- 입출력, stdout / stderr / redirect
    
    ```bash
    # all stdout, stderr to null
    command >/dev/null 2>&1
    
    # stderr to null
    command 2> /dev/null
    
    # stderr to stdout
    command 2>&1
    
    ## append
    command >> sample.txt
    
    ## overwrite
    command > sample.txt
    
    ```
    
- 스케쥴링, crontab
    
    ```bash
    # tty에서 사용자가 실행하는것과 크론탭이 자동으로 실행하는 환경 간에는 PATH 환경변수가 다르므로, 프로그램 절대 경로 사용
    /usr/bin/echo "hello"
    ```
    
- 조건문, if
    
    ```bash
    if [ condition ]
    then
    	logic
    else
    	logic
    fi
    
    # condition
    # 문자열
    s1 = s2	s1과 s2가 같은지
    s1 != s2	s1과 s2가 같지 않은지
    s1 \< s2	s1이 s2보다 작은지(부등호 앞에 \를 꼭 붙여준다) ( [] 사용시 )
    s1 \> s2	s1이 s2보다 큰지(부등호 앞에 \를 꼭 붙여준다) ( [] 사용시 )
    [ -z ] : 문자열의 길이가 0이면 참 (문자열이 아무것도 없으면)
    [ -n ] : 문자열의 길이가 0이 아니면 참 (0보다 길면)
    
    # 숫자
    [ -eq ] : 값이 같으면 참
    [ -ne ] : 값이 다르면 참
    [ -gt ] :  값1 > 값2
    [ -ge ] : 값1  >= 값2
    [ -lt ] : 값1 < 값2
    [ -le ] : 값1 <= 값2
    
    # 논리연산
    [ -a ] : &&연산과 동일 and 연산
    [ -o ] : ||연산과 동일 xor 연산
    [ && ]
    [ || ]
    
    # 파일 관련
    [ -d ] : 파일이 디렉토리면 참
    [ -e ] : 파일이 있으면 참
    [ -L ] : 파일이 심볼릭 링크면 참
    [ -r ] : 파일이 읽기 가능하면 참
    
    [ -s ] : 파일의 크기가 0 보다 크면 참
    [ -w ] : 파일이 쓰기 가능하면 참
    [ -x ] : 파일이 실행 가능하면 참
    
    [ 파일1 -nt 파일2 ]  : 파일1이 파일2보다 최신파일이면 참
    [ 파일1 -ot 파일2 ]  : 파일1이 파일2보다 이전파일이면 참
    [ 파일1 -ef 파일2 ] : 파일1이 파일2랑 같은 파일이면 참
    
    # [], [[]], (), (())
    []
    쉘 조건문의 표준버전, posix 유틸리티 표준, 파일 존재 여부, 숫자 비교에 사용 가능
    
    [[]]
    []의업그레이드 버전, 거의 모든 쉘에서 지원, 논리연산자(<,>,&&,||)를 인식
    
    ()
    커맨드 실행 성공여부 판단
    if (command)
    
    (())
    산술연산할때 주로 사용
    (( 1+2 ))
    ```
    
- 날짜확인, date
    
    ```bash
    date '+%Y-%m-%d %H:%M:%S'
    2023-06-23 08:06:34
    
    # 연/월/일 만
    date -I
    2023-07-01
    
    # 간편 시간 포맷, %H:%M:%S
    # %T   time; same as %H:%M:%S
    date +%T
    09:27:29
    
    date '+%Y-%m-%d %T'
    2023-07-01 09:27:33
    ```
    
- 서버 타임존 설정, tzselect
    
    ```python
    # 한국시간설정
    # 방법 1: 로컬타임 파일의 심볼릭 링크 변경
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
    # 변경 후: /etc/localtime -> /usr/share/zoneinfo/Asia/Seoul
    
    # 방법 2: timedatectl
    # 조회
    timesatectl
    # 변경
    timedatectl set-timezone 'Asia/Seoul'
    
    # 방법 3: tzselect
    Asia > Korea South 선택 > /etc/profile에 'TZ='Asia/Seoul'; export TZ' 입력
    ```
    
- 문자열 내 변수, 커맨드
    
    ```bash
    # variables in string, {}
    echo "$a foo"
    echo "${a} foo"
    
    # 작은따옴표 '' 안에서는 변수 인식 안됨
    
    # command in string, ()
    echo "$(date '+%Y-%m-%d %H:%m:%S') foo"
    
    ```
    
- Debug, set -exuo pipefail
    
    문법 검사 사이트: [shell check](https://www.shellcheck.net/)
    
    ```bash
    e : errexit, 첫번째 실행 실패 (exit코드가 0이 아닌 상태로 종료하는 명령어)시 쉘 스크립트를 종료
    x: xtrace, 매 라인을 실행하기 전에 필요한 산술확장, 매개변수 확장, 명명치환, 변수 대입등을 화면에 출력
    u: nounset, 정의가 안된 변수를 사용하면 에러 메세지를 출력하고 쉘 프로그램 강제 종료
    o: 옵션을 on/off 하는 기능
    	set -o : 옵션 on
    	set +o : 옵션 off
    	pipefail: 옵션명, 파이프로 연결된 명령이 전부 true일 때만 true를 반환하도록 함
    
    # usage
    # 스크립트 맨 윗줄에 선언
    
    	#!/bin/bash
    	set -exuo pipefail
    	
    	function add (){
    	  a=$1
    	  b=$2
    	  echo $(($a + $b))
    	}
    	function minus () {
    	  a=$1
    	  b=$2
    	  echo $(($a - $b))
    	}
    	add 1 2
    	minus 4 5
    
    # output example
    	+ add 1 2
    	+ a=1
    	+ b=2
    	+ echo 3
    	3
    	+ minus 4 5
    	+ a=4
    	+ b=5
    	+ echo -1
    	-1
    ```
    
- 파일 속성 조회, stat
    
    ```bash
    # stat <filename>
    stat test.sh
    ```
    
- 파일 속성 변경, touch
    
    ```bash
    # touch -t <date> <filename>
    touch -t 202201010000 test.sh
    ```
    
- 사용자 입력, read
    
    ```bash
    # read <변수>
    read A
    read B
    echo $A $B
    ```
    
- 함수, function
    
    ```bash
    # function name () {
    #  logic
    # }
    
    function add () {
    	A=$1
    	B=$2
    	echo $(($a + $b))
    }
    add 1 2
    
    ```
    
- 연산, (())
    
    ```bash
    # $(())
    echo $(($a + $b))
    ```
    
- 파일 찾기, find
    
    ```bash
    # find <경로> <파일이름 or 표현식> <옵션>
    find /var -name yum.log
    find /var -name "*.log" 
    
    -type : 타입, d, f, l(심볼릭)
    -name : 파일, 디렉터리 이름
    -exec : find 후 명령 실행
    
    # 사이즈 기준으로 검색
    find . -size +1k
    find . -size -1k
    find . -size +1k -size -10k
    
    # find 후 명령 실행
    # 중괄호, {} 안에 find로 찾은 인자가 들어감
    find /var -name "*.log" -exec ls -al {} \;
    ```
    
- 파일 목록 재귀 조회
    
    ```bash
    ls -lR
    ```
    
- 디렉토리/파일용량 조회
    
    ```bash
    # du <option> <path>
    du -sh /var
    
    # -h: human readable
    du /var -h --max-depth=1 2>/dev/null
    
    # all file
    du . -a -h
    
    # summarize
    du -sh
    ```
    
- 커맨드 시간 제한
    
    ```bash
    # timeout sec command
    timeout 5s top
    ```
    
- 프로세스 조회
    
    ```bash
    # Show all active precess
    # Standard 문법
    ps -ef
    
    # BSD 문법
    ps aux
    
    # tree 구조
    ps axjf
    ps -ejH
    ```
    
- 부하 생성, stress
    
    ```bash
    # cpu
    stress --cpu <코어수> --timeout 20s -v
    
    # mem
    stress --vm <프로세스수> --vm-bytes <사용할 크기>M --timeout 20s -v
    
    # disk
    stress --hdd <디스크 수> --hdd-bytes <사용할 크기>M --timeout 20s -v
    ```