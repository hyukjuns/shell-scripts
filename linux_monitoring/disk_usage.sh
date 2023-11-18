#!/bin/bash

# Set general variables
HOST=$(hostname)
DATE=$(date '+%Y-%m-%d_%T')
DATE_SHORT=$(date '+%Y-%m-%d')

# Check Disk Usage
TARGET=$(df -h | awk '{gsub("%","");USE=$5; MNT=$6; THRESHOLD=90; if(USE>THRESHOLD) print $5"%", $6}' | grep -v '^[A-Z]')

# 2. if disk usage over threshold, send slack alert to engineer with disk mount path
if [[ -n $TARGET ]]
then
{ 
  /bin/echo "${DATE}, Warning, Disk Usage Over 90%, $TARGET"
  /bin/bash ./slack.sh "Disk Usage" "${DATE} Warning  Disk Usage Over 90%, \n $TARGET" >/dev/null 2>&1
} >> "${DATE_SHORT}_disk_log.txt"
else
{
  /bin/echo "${DATE}, OK"
} >> "${DATE_SHORT}_disk_log.txt"
fi