#!/bin/bash -eu

buildDir=$1

if [[ ! -d $buildDir ]] ; then
    echo "goto Error: No directory exists at $buildDir" >&2
    exit 1
fi

absBldDir=$(readlink -f $buildDir/)
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
