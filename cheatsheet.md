### 쉘스크립트 시나리오 (모니터링, 시스템 관리)
1. Send Message (slack webhook)
2. OS 시스템 상태 모니터링 - CPU / Mem / Disk
    - CPU 70% 이상 사용
    - mem 1gb 이하
    - disk full
3. 메모리 과다 사용 프로세스 찾기
4. 좀비 프로세스 찾기
5. 웹서버 로그 순환, 웹서버 상태체크
6. 네트워크 상태 모니터링, 현재 활성 세션 개수 카운트 (ESTABLISHED)
7. 파일 백업 & 스케쥴링

### Commands

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
    ```
    
- 날짜확인, date
    
    ```bash
    date '+%Y-%m-%d %H:%m:%S'
    2023-06-23 08:06:34
    ```
    
- 문자열 내 변수, 커맨드
    
    ```bash
    # variables in string, {}
    echo "$a foo"
    echo "${a} foo"
    
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
    ps -ef
    ps -aux
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