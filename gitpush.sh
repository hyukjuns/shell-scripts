#!/bin/zsh
MESSAGE=$1
git add .
git commit -m "$(date '+%Y-%m-%d %H:%M') update $MESSAGE"
git push