#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file
NICE=0

while IFS= read -r line; do
    if [[ "$line" =~ ab|cd|pq|xy ]]; then
        continue
    fi
    NUMVOWELS=0
    if [[ "$line" =~ ([a-z])\1|[aeiou] ]]; then ## Get all lines with vowels
        for (( i=0; i<${#line}; i++ )); do ## Loop through characters and count the vowels
            if [[ ${line:$i:1} =~ a|e|i|o|u ]]; then
                NUMVOWELS=$(($NUMVOWELS+1))
            fi
        done
    fi
    if (($NUMVOWELS >= 3)) && grep -Pq '([a-z])\1' - <<< $line; then ## If there are 3 vowels and 2 of the same character...
        NICE=$(($NICE+1))
    fi
done <<< "$INPUT"

echo "$NICE"