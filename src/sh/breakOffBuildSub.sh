#!/bin/bash -eu

projectDir=$1
bldDir=$2

absBldDir=$(readlink -f $bldDir)

echo $absBldDir \
    | sed "s+$projectDir++" \
    | sed 's+^/++'
