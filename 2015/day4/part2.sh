#!/usr/bin/env bash

## Took about 10 mins

## Kill all processes 
## kill $(pgrep -f "bash ./part2")

INPUT="ckczppom"
T="$(date +%s)"
pids=()

checkHashes(){
    local RANGE=100000 ## Do in rounds of 100k numbers
    local START=$(( $1 * $RANGE ))
    local END=$(( ($1+1) * $RANGE ))

    for i in $(seq $START $END ); do
        local MD5=$(md5sum <(echo -n "${INPUT}${i}")) ## Calculate MD5
        if [ "${MD5:0:6}" == "000000" ]; then ## Grab first 6 characters and check if they are 000000
            T="$(($(date +%s)-T))"
            echo "Found $i, ${MD5:0:32} in ${T} seconds"
            pkill -P $$
            exit 0
        fi
    done

    echo "Nothing found in $1" ## More of a sanity check
}

for i in {0..100}; do ## Probably overkill but oh well
    checkHashes $i&
    pids[${i}]=$!
done

for pid in ${pids[*]}; do
    wait $pid
done