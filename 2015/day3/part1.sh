#!/usr/bin/env bash

INPUT=$(<input)
X=0
Y=0

declare -A MAP
MAP=(["$X,$Y"]=1)

for (( i=0; i<${#INPUT}; i++ )); do
    DIR=${INPUT:$i:1}
    if [ "$DIR" == "^" ]; then
        Y=$(($Y - 1))
    elif [ "$DIR" == "v" ]; then
        Y=$(($Y + 1))
    elif [ "$DIR" == ">" ]; then
        X=$(($X + 1))
    elif [ "$DIR" == "<" ]; then
        X=$(($X - 1))
    fi

    MAP["$X,$Y"]=$((${MAP["$X,$Y"]} + 1))
done

HOUSES=0
for i in "${!MAP[@]}"; do
    if ((${MAP[$i]} >= 1 )); then
        HOUSES=$(($HOUSES+1))
    fi
done

echo "Number of houses who got at least one present: $HOUSES"