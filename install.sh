#!/bin/bash -eu

scriptDir=$(dirname $(readlink -f $0))

if [[ $# -eq 0 ]] ; then
    binDir=/usr/local/bin/
    shareDir=/usr/local/share/goto/
    
elif [[ $# -eq 1 ]] ; then
    shareDir=$scriptDir/lib/share/
    binDir=$1
    
else
    shareDir=$1
    binDir=$2
fi

binPath=$binDir/goto

mkdir -p $binDir $shareDir

shSrc=$scriptDir/src/sh/

function installShareScripts() {
    sed "s+\(.*\)/\(.*\).sh+cp & $shareDir/\2+" \
	| bash
}

mkdir -p $shareDir
ls $shSrc/*.sh | installShareScripts
chmod a+x $shareDir/*

if [[ -L $binPath ]] ; then
    unlink $binPath
fi

ln -s $shareDir/main $binPath


