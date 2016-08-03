#!/bin/bash -eu

scriptDir=$(dirname $(readlink -f $0))

if [[ $# -gt 0 ]] ; then
    installRoot=$(readlink -f $1)
else
    installRoot=/usr/local/
fi

shareDir=$installRoot/share/goto/
binDir=$installRoot/bin/
binPath=$binDir/goto

mkdir -p $binDir $shareDir

shSrc=$scriptDir/src/sh/

function installShareScripts() {
    sed "s+\(.*\)/\(.*\).sh+cp & $shareDir/\2+" \
	| bash
}

ls $shSrc/*.sh | installShareScripts
chmod a+x $shareDir/*

if [[ -L $binPath ]] ; then
    unlink $binPath
fi

ln -s $shareDir/main $binPath
