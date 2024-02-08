#!/bin/bash

BRANCHY=

if [ -n "$1" ]; then
    BRANCHY=$1
    echo "BRANCHY=$BRANCHY" >> $GITHUB_ENV
    echo "The argument is: $1"
    echo "Something is stored in \$BRANCHY which is $BRANCHY"
else
    echo "No argument found."
fi