#!/bin/bash

# FRUITS=$(jq -c '.fruits[]' ./data.json) // removes the array
FRUITS=($(jq -r '.fruits[]' ./data.json))

echo $FRUITS
echo ${FRUITS[@]}
echo You have a total of ${#FRUITS[@]} fruits.

FRUITY_FLAG=

if [ ${#FRUITS[@]} -gt 1 ]; then
    for FRUIT in ${FRUITS[@]}
    do
        FRUITY_FLAG="${FRUITY_FLAG} --include-fruit ${FRUIT}"
    done
else
    FRUITY_FLAG=--no-fruits-included
fi

echo rover publish $FRUITY_FLAG