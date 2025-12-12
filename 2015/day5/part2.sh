#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file
NICE=0

while IFS= read -r line; do
    if grep -Pq '(..).*\1' - <<< $line && grep -Pq '(.).\1' - <<< $line ; then  ## Find pairs of letters, and pairs with letter between (. is magic!)
        NICE=$(($NICE+1))
    fi
done <<< "$INPUT"

echo "$NICE"