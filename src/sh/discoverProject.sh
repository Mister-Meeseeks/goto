#!/bin/bash -eu

buildDir=$1

absBldDir=$(readlink -f $buildDir)
iterSearchDir=$absBldDir

while [[ $iterSearchDir != "/" ]] ; do
    if [[ -e $iterSearchDir/$gotoCfgBase ]] ; then
	echo $iterSearchDir
	exit 0
    fi
    iterSearchDir=$(dirname $iterSearchDir)
done

# Non-goto project. Use buildDir as workspace source...
echo $buildDir
