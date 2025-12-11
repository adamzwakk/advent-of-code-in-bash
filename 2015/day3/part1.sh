#!/usr/bin/env bash

INPUT=$(<input)
X=0
Y=0

declare -A MAP
MAP=(["$X,$Y"]=1) ## The first house always gets a present

for (( i=0; i<${#INPUT}; i++ )); do
    DIR=${INPUT:$i:1}
    ## Get X/Y Coordinate of present relative to the start
    if [ "$DIR" == "^" ]; then
        Y=$(($Y - 1))
    elif [ "$DIR" == "v" ]; then
        Y=$(($Y + 1))
    elif [ "$DIR" == ">" ]; then
        X=$(($X + 1))
    elif [ "$DIR" == "<" ]; then
        X=$(($X - 1))
    fi

    MAP["$X,$Y"]=$((${MAP["$X,$Y"]} + 1)) ## Add a present count to that house
done

HOUSES=0
for i in "${!MAP[@]}"; do
    if ((${MAP[$i]} >= 1 )); then
        HOUSES=$(($HOUSES+1)) ## Get count of all houses that got presents
    fi
done

echo "Number of houses who got at least one present: $HOUSES"