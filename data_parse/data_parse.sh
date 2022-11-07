#!/bin/bash

# PT1H -> month, day, hour, minute

month=08
for day in {1..31}
do
    for hour in {1..23}
    do
        if [ $hour -lt 10 ]
        then
            if [ $day -lt 10 ]
            then
                path="./m=$month/d=0$day/h=0$hour/m=00/PT1H.json"
            else
                path="./m=$month/d=$day/h=0$hour/m=00/PT1H.json"    
            fi
        else
            if [ $day -lt 10 ]
            then
                path="./m=$month/d=0$day/h=$hour/m=00/PT1H.json"
            else
                path="./m=$month/d=$day/h=$hour/m=00/PT1H.json"
            fi
        fi
        cat "$path" | jq '.' >> temp.txt
        echo "----$month월 $day일  $hour시간 ----" >> test.txt
    done
done
