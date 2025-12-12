#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file
regex="([0-9]{1,3},[0-9]{1,3}) through ([0-9]{1,3},[0-9]{1,3})"
BRIGHTNESS=0

## Set up lightmap with everything off
declare -A LIGHTMAP
for ((i=1;i<=999;i++)) do
    for ((j=1;j<=999;j++)) do
        LIGHTMAP[$i,$j]=0
    done
done

changelight(){
    TYPE=$3
    X=("${1%%,*}" "${2%%,*}") ## Seperate X and Y start/end
    Y=("${1#*,}" "${2#*,}")
    for ((i=${X[0]};i<=${X[1]};i++)) do
        for ((j=${Y[0]};j<=${Y[1]};j++)) do
            if (( $TYPE == 0)); then ## If Off
                if ((${LIGHTMAP[$i,$j]} != 0)); then
                    LIGHTMAP[$i,$j]=$((${LIGHTMAP[$i,$j]}-1))
                fi
            elif (( $TYPE == 1)); then ## If On
                LIGHTMAP[$i,$j]=$((${LIGHTMAP[$i,$j]}+1))
            elif (( $TYPE == 2)); then ## If Toggle
                LIGHTMAP[$i,$j]=$((${LIGHTMAP[$i,$j]}+2))
            fi
        done
    done
}

while IFS= read -r line; do
    if [[ $line =~ $regex ]]; then ## Get the two sets of numbers from the line
        read -r START _ END <<< "${BASH_REMATCH[0]}"
    fi
    if [[ $line == "turn off"* ]]; then
        changelight $START $END 0
    elif [[ $line == "turn on"* ]]; then
        changelight $START $END 1
    elif [[ $line == "toggle"* ]]; then
        changelight $START $END 2
    fi
done <<< "$INPUT"

## Calulate combined brightness values
for ((i=1;i<=999;i++)) do
    for ((j=1;j<=999;j++)) do
        BRIGHTNESS=$(($BRIGHTNESS + ${LIGHTMAP[$i,$j]}))
    done
done

echo $BRIGHTNESS