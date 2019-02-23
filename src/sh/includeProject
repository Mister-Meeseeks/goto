#!/bin/bash -eu

importPath=$1; shift
workspaceDir=$1; shift
relativePathRoot=$@

function resolveAbsolutePath() {
    local resolvePath=$1
    if [[ $resolvePath == /* ]] ; then
	echo $resolvePath
    else
	echo $relativePathRoot/$resolvePath
    fi
}

projectDir=$(resolveAbsolutePath $importPath)

if [[ -e $projectDir/$gotoCfgBase ]] ; then
    processConfig $projectDir/$gotoCfgBase
fi

stageSource $projectDir $workspaceDir
