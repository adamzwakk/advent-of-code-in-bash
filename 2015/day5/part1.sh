#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file
NICE=0

while IFS= read -r line; do
    if [[ "$line" =~ ab|cd|pq|xy ]]; then
        continue
    fi
    if [[ "$line" =~ ([aeiou].*){3,} ]]; then
        NICE=$(($NICE+1))
        # echo "vowels: $line"
    elif echo "$line" | grep -Pq '(.)\1'; then
        NICE=$(($NICE+1))
        echo "double chars: $line"
    fi
    # echo "$line"
done <<< "$INPUT"

echo "$NICE"