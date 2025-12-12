#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file

declare -A WIRES
declare -A SOLVEDWIRES

check_if_we_can_solve(){
    for i in "${!WIRES[@]}"; do
        for j in "${!SOLVEDWIRES[@]}"; do
            if [[ ${WIRES[$i]} == "$j RSHIFT"* ]]; then
                read -r _ _ SHIFT <<< "${WIRES[$i]}"
                SOLVEDWIRES[$i]=$((${SOLVEDWIRES[$j]} >> $SHIFT))
                unset WIRES[$i]
            elif [[ ${WIRES[$i]} == "$j LSHIFT"* ]]; then
                read -r _ _ SHIFT <<< "${WIRES[$i]}"
                SOLVEDWIRES[$i]=$(( ${SOLVEDWIRES[$j]} << $SHIFT ))
                unset WIRES[$i]
            elif [[ ${WIRES[$i]} == "$j AND"* ]]; then
                for k in "${!SOLVEDWIRES[@]}"; do
                    ## Find the other potential solved var here
                done
                echo "Found an AND ${WIRES[$i]}"
            fi
        done
    done
}

while IFS= read -r line; do
    INSTRUCT="${line% ->*}"
    WIREEND="${line##*> }"

    if [[ "$line" =~ ^([0-9]{1,})\ \-\> ]]; then
        SOLVEDWIRES[$WIREEND]="${BASH_REMATCH[1]}"
    else
        WIRES[$WIREEND]=$INSTRUCT
    fi

    check_if_we_can_solve
done <<< "$INPUT"

for i in "${!SOLVEDWIRES[@]}"; do
    echo "$i: ${SOLVEDWIRES[$i]}"
done
