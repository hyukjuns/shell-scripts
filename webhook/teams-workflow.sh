#!/bin/bash
set -o pipefail

URL=""
HEADER="Content-Type: application/json"
DATA=$(cat <<EOF
{
       "type":"message",
       "attachments":[
          {
             "contentType":"application/vnd.microsoft.card.adaptive",
             "contentUrl":null,
             "content":{
                "$schema":"http://adaptivecards.io/schemas/adaptive-card.json",
                "type":"AdaptiveCard",
                "version":"1.2",
                "body":[
                    {
                    "type": "TextBlock",
                    "text": "안녕하세요"
                    }
                ]
             }
          }
       ]
    }
EOF
)

echo $DATA
curl -X POST -H "$HEADER" -d "$DATA" $URL