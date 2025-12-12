#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file
NICE=0

while IFS= read -r line; do
    if [[ "$line" =~ ab|cd|pq|xy ]]; then
        continue
    fi
    NUMVOWELS=0
    if [[ "$line" =~ ([a-z])\1|[aeiou] ]]; then
        for (( i=0; i<${#line}; i++ )); do
            if [[ ${line:$i:1} =~ a|e|i|o|u ]]; then
                NUMVOWELS=$(($NUMVOWELS+1))
            fi
        done
    fi
    if (($NUMVOWELS >= 3)) && grep -Pq '([a-z])\1' - <<< $line; then
        NICE=$(($NICE+1))
    fi
    # echo "$line"
done <<< "$INPUT"

echo "$NICE"