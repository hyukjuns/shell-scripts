#!/bin/bash

# data
data=$(cat <<EOF
{
  "channel": "#<CHANNEL_NAME>",
  "username": "$(hostname)",
  "blocks": [
    {
      "type": "section",
      "text": {
        "type": "plain_text",
        "text": "This is a plain text section block.",
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

