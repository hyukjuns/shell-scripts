#!/bin/bash
set -o pipefail

URL=""
HEADER="Content-Type: application/json"
DATA=$(cat <<EOF
{
    "text": "hello world"
}
EOF
)

echo $DATA
curl -X POST -H "$HEADER" -d "$DATA" $URL