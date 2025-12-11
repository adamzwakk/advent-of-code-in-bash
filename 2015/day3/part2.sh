#!/usr/bin/env bash

INPUT=$(<input)
SX=0
SY=0
RX=0
RY=0

declare -A MAP
MAP=(["0,0"]=1) ## The first house always gets a present

for (( i=0; i<${#INPUT}; i++ )); do
    DIR=${INPUT:$i:1}
    if (($i % 2 == 0)); then ## Santa on 0 and even numbers
        ## Get X/Y Coordinate of present relative to the start
        if [ "$DIR" == "^" ]; then
            SY=$(($SY - 1))
        elif [ "$DIR" == "v" ]; then
            SY=$(($SY + 1))
        elif [ "$DIR" == ">" ]; then
            SX=$(($SX + 1))
        elif [ "$DIR" == "<" ]; then
            SX=$(($SX - 1))
        fi
        MAP["$SX,$SY"]=$((${MAP["$SX,$SY"]} + 1)) ## Add a present count to that house
    else
        ## Get X/Y Coordinate of present relative to the start
        if [ "$DIR" == "^" ]; then
            RY=$(($RY - 1))
        elif [ "$DIR" == "v" ]; then
            RY=$(($RY + 1))
        elif [ "$DIR" == ">" ]; then
            RX=$(($RX + 1))
        elif [ "$DIR" == "<" ]; then
            RX=$(($RX - 1))
        fi
        MAP["$RX,$RY"]=$((${MAP["$RX,$RY"]} + 1)) ## Add a present count to that house
    fi
done

HOUSES=0
for i in "${!MAP[@]}"; do
    if ((${MAP[$i]} >= 1 )); then
        HOUSES=$(($HOUSES+1)) ## Get count of all houses that got presents
    fi
done

echo "Number of houses who got at least one present: $HOUSES"