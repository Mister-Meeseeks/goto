#!/bin/bash -eu

projectDir=$1
workspaceDir=$2

if [[ -e $projectDir/$gotoCfgBase ]] ; then
    processConfig $projectDir/$gotoCfgBase
fi

stageSource $projectDir $workspaceDir
