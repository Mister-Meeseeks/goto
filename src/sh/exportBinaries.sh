#!/bin/bash -eu

outputPath=$1

if [[ -d $outputPath ]] ; then
    sed "s+.*+cp & $outputPath/+" | bash
elif [[ -e $outputPath ]] ; then
    sed "s+.*+cp & $outputPath+" | head -n 1 | bash
fi

