#!/usr/bin/env bash

INPUT=$(<input) ## Grab from file
# OR INPUT=$(</dev/stdin) if you want stdin

FLOORUP=${INPUT//)/} ## Filter to only ( symbols
FLOORDOWN=${INPUT//(/} ## Filter to only ) symbols

FLOOR=$(( ${#FLOORUP} - ${#FLOORDOWN} )) ## Get Counts of both and done!

echo $FLOOR