#!/usr/bin/env bash

IFS=x ## Change IFS to separate by 'x' to split the values
PAPERTOTAL=0
RIBBONTOTAL=0

while read -r line; do
    DIMS=($line) ## Split by IFS into array
    DIMS[2]=${DIMS[2]::-1} ## Kill new line character
    AREA=()

    AREA[0]=$(( ${DIMS[0]} * ${DIMS[1]} )) # Length
    AREA[1]=$(( ${DIMS[1]} * ${DIMS[2]} )) # Width
    AREA[2]=$(( ${DIMS[2]} * ${DIMS[0]} )) # Height

    BOXTOTAL=$(( ( ${AREA[0]} * 2) + ( ${AREA[1]} * 2 ) + ( ${AREA[2]} * 2 )))

    S=($(echo "${AREA[@]}" | tr ' ' '\n' | sort -n | head -n 1)) ## Smallest number/slack
    SD=($(echo "${DIMS[@]}" | tr ' ' '\n' | sort -n | head -n 2 | tr '\n' 'x')) ## Smallest dimensions (separate by x because of IFS)

    RIBBON=$(( ${SD[0]} + ${SD[0]} + ${SD[1]} + ${SD[1]} ))
    BOW=$(( ${DIMS[0]} * ${DIMS[1]} * ${DIMS[2]} ))

    RIBBONTOTAL=$(($RIBBONTOTAL + $RIBBON + $BOW))
    PAPERTOTAL=$(($PAPERTOTAL + $BOXTOTAL + ${S[0]}))
done <input

echo "Paper Total $PAPERTOTAL, RIBBON TOTAL: $RIBBONTOTAL"