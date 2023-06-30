#!/bin/bash

# FORM
# hostname에서 cpu/mem/disk 이슈 발생
# <경고메세지> 

# 모니터링 대상
TARGET=$1
# 경고메세지
MESSAGE=$2

# data
data=$(cat <<EOF
{
  "channel": "#infra-alert",
  "username": "$(hostname)",
  "blocks": [
    {
      "type": "section",
      "text": {
        "type": "plain_text",
        "text": "$(date '+%Y-%m-%d %H:%M:%S') \n $(hostname)에서 $TARGET 이슈 발생, \n [경고메세지] \n $MESSAGE",
        "emoji": true
      }
    }
  ]
}
EOF
)

# slack webhook url
URL="https://hooks.slack.com/services/<SLACK_WEBHOOK_API_TOKEN>"

# send to slack
curl -X POST --data-urlencode "payload=$data" $URL 

#curl -X POST --data-urlencode "payload={\"channel\": \"#infra-alert\", \"username\": \"$(hostname)\", \"text\": \"This is posted to #infra-alert and comes from a bot named webhookbot.\", \"icon_emoji\": \":ghost:\"}" ${URL}
