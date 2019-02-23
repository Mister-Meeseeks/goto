#!/bin/bash -eu

scriptDir=$(dirname $(readlink -f $0))

if [[ $# -eq 0 ]] ; then
    binDir=/usr/local/bin/
    shareDir=/usr/local/share/goto/
    
elif [[ $# -eq 1 ]] ; then
    binDir=$1
    shareDir=""
else
    shareDir=$1
    binDir=$2
fi

binPath=$binDir/goto

mkdir -p $binDir $shareDir

shSrc=$scriptDir/src/sh/

function installShareScripts() {
    sed "s+\(.*\)/\(.*\)+cp & $shareDir/\2+" \
	| bash
}

if [[ ! -z $shareDir ]] ; then
    mkdir -p $shareDir
    ls $shSrc/* | installShareScripts
    chmod a+x $shareDir/*
else
    shareDir=$(readlink -f $shSrc)
fi
    
if [[ -L $binPath ]] ; then
    unlink $binPath
fi

ln -s $shareDir/main $binPath


