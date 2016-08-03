#!/bin/bash -eu

workspaceDir=$1;
shift; subPathArg=$@

function selectSubPath() {
    if [[ $# -eq 0 ]] ; then
	echo root
    else
	echo $1
    fi
}

function sanitizeWorkspacePath() {
    local workspaceDir=$1
    readlink -f $workspaceDir
}

subPath=$(selectSubPath $subPathArg)
export GOPATH=$(sanitizeWorkspacePath $workspaceDir)
go install $subPath

if [[ ! -z $(ls $workspaceDir/bin/) ]] ; then
    ls $workspaceDir/bin/*
fi
