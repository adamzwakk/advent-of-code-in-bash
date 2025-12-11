#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file
# OR INPUT=$(</dev/stdin) if you want stdin
FOUNDBASEMENT=0

for (( i=0; i<${#INPUT}; i++ )); do ## Loop through each character at an index
        CHAR=${INPUT:$i:1} # Get the indexed character
        if [ "$CHAR" == "(" ]; then
                ((FLOOR++))
        elif [ "$CHAR" == ")" ]; then
                ((FLOOR--))
        fi

        if [ $FLOOR -lt 0 ] && [ $FOUNDBASEMENT == 0 ]; then ## Once we're below 0, log the index
            BASEMENTINDEX=$(($i + 1)) ## They want the character count, not the index persay
            echo "Found the basement at $BASEMENTINDEX"
            FOUNDBASEMENT=1
        fi
done