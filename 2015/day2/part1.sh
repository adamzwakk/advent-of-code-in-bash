#!/usr/bin/env bash

IFS=x ## Change IFS to separate by 'x' to split the values
TOTAL=0

while read -r line; do
    DIMS=($line) ## Split by IFS into array
    DIMS[2]=${DIMS[2]::-1} ## Kill new line character
    AREA=()

    AREA[0]=$(( ${DIMS[0]} * ${DIMS[1]} )) # Length
    AREA[1]=$(( ${DIMS[1]} * ${DIMS[2]} )) # Width
    AREA[2]=$(( ${DIMS[2]} * ${DIMS[0]} )) # Height

    BOXTOTAL=$(( ( ${AREA[0]} * 2) + ( ${AREA[1]} * 2 ) + ( ${AREA[2]} * 2 )))

    S=$(echo "${AREA[@]}" | tr ' ' '\n' | sort -n | head -n 1) ## Smallest number/slack

    TOTAL=$(($TOTAL + $BOXTOTAL + $S))
done <input

echo $TOTAL