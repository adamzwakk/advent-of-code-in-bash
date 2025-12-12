#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file
regex="([0-9]{1,3},[0-9]{1,3}) through ([0-9]{1,3},[0-9]{1,3})"
LIGHTSON=0

## Set up lightmap with everything off
declare -A LIGHTMAP
for ((i=1;i<=999;i++)) do
    for ((j=1;j<=999;j++)) do
        LIGHTMAP[$i,$j]=0
    done
done

changelight(){
    TYPE=$3
    X=($(echo $1 | cut -d ',' -f 1) $(echo $2 | cut -d ',' -f 1))
    Y=($(echo $1 | cut -d ',' -f 2) $(echo $2 | cut -d ',' -f 2))
    for ((i=${X[0]};i<=${X[1]};i++)) do
        for ((j=${Y[0]};j<=${Y[1]};j++)) do
            if (( $TYPE == 0)) && ((${LIGHTMAP[$i,$j]} == 1)); then
                LIGHTMAP[$i,$j]=0
                LIGHTSON=$(($LIGHTSON-1))
            elif (( $TYPE == 1)) && ((${LIGHTMAP[$i,$j]} == 0)); then
                LIGHTMAP[$i,$j]=1
                LIGHTSON=$(($LIGHTSON+1))
            elif (( $TYPE == 2)); then
                if (( ${LIGHTMAP[$i,$j]} == 0)); then
                    LIGHTMAP[$i,$j]=1
                    LIGHTSON=$(($LIGHTSON+1))
                else
                    LIGHTMAP[$i,$j]=0
                    LIGHTSON=$(($LIGHTSON-1))
                fi
            fi
        done
    done
}

while IFS= read -r line; do
    if [[ $line =~ $regex ]]; then
        START=$(echo -n "${BASH_REMATCH[0]}" | awk '{print $1}')
        END=$(echo -n "${BASH_REMATCH[0]}" | awk '{print $3}')
    fi
    if [[ $line == "turn off"* ]]; then
        changelight $START $END 0
    elif [[ $line == "turn on"* ]]; then
        changelight $START $END 1
    elif [[ $line == "toggle"* ]]; then
        changelight $START $END 2
    fi
done <<< "$INPUT"

echo $LIGHTSON