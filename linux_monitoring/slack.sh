#!/bin/bash

# slack webhook url
URL="https://hooks.slack.com/services/<SLACK_WEBHOOK_API_TOKEN>"

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

# send to slack
curl -X POST --data-urlencode "payload=$data" $URL 