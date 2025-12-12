#!/usr/bin/env bash

## Took about 2 mins

# Code is abcdef + lowest found number = 000001dbbfa3a5c83a2d506429c7b00e
# EXAMPLE=$(md5sum <(echo -n "abcdef609043") | head -c 32)
# echo "$EXAMPLE"

show_number(){
    echo "Ended on $i"
    exit 1
}

INPUT="ckczppom"
T="$(date +%s)"

trap show_number INT ## Mainly just want to give up when I want but know where it stopped

i=0
while :; do ## Infinite loop while incing i
    MD5=$(md5sum <(echo -n "${INPUT}${i}")) ## Calculate MD5
    if [ "${MD5:0:5}" == "00000" ]; then ## Grab first 5 characters and check if they are 00000
        T="$(($(date +%s)-T))"
        echo "Found $i, ${MD5:0:32} in ${T} seconds"
        exit 0
    fi
    i=$((i+1))
done

