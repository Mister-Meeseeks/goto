#!/bin/bash -eu

# TODO: Replace with readable command-line args
projectDir=.
subPath=$1

gotoCfg=$projectDir/goto.cfg

gotoWorkSubDir=.goto
gotoWorkDir=$projectDir/$gotoWorkSubDir/
localWorkspace=$gotoWorkDir/local/
importWorkspaces=$gotoWorkDir/imports/
federatedWorkspace=$gotoWorkDir/federated/

function resetWorkDir() {
    if [[ -d $gotoWorkDir ]] ; then
	rm -r $gotoWorkDir
    fi
    mkdir -p $localWorkspace $importWorkspaces $federatedWorkspace
}

function stageProjectSource() {
    local projectDir=$1
    local workspaceDir=$2
    plantRootTreeWorkspaces $workspaceDir
    mirrorProjectSource $projectDir $workspaceDir
}

function plantRootTreeWorkspaces() {
    local workspaceDir=$1
    mkdir -p $workspaceDir/
    mkdir -p $workspaceDir/root/
}

function mirrorProjectSource() {
    local projectDir=$1
    local workspaceDir=$2
    listProjectMembers $projectDir -type d \
	| makeSubDirectories $workspaceDir/
    listProjectMembers $projectDir -mindepth 2 -type f \
	| copyTreeFiles $workspaceDir/
    listProjectMembers $projectDir -maxdepth 1 -type f \
	| copyTreeFiles $workspaceDir/root/
}

function listProjectMembers() {
    local projectDir=$1
    local cond="$@"
    find $projectDir $cond -printf "%P\n" \
	| grep -v "^$gotoWorkSubDir"
}

function makeSubDirectories() {
    local workspaceDir=$1
    sed "s+.*+mkdir -p $workspaceDir/&+" | bash
}

function copyTreeFiles() {
    local workspaceDir=$1
    sed "s+.*+cp $projectDir/& $workspaceDir/&+" | bash
}

function installWorkspace() {
    local workspaceDir=$1
    shift; local subPath=$@
    [[ $# -eq 0 ]] && subPath=root
    export GOPATH=$(readlink -f $workspaceDir)
    go install $subPath
}

function federateWorkspaces() {
    mkdir -p $federatedWorkspace/src/
    for i in $(ls $importWorkspaces/) ; do
	fedetateImport $i
    done
    fedateLocal
}

function federateImports() {
    for i in $(ls $importWorkspaces/) ; do
	fedetateImport $i
    done
}

function federateImport() {
    local importName=$1
    cp -r $importWorkspaces/$i/ $federatedWorkspace/src/$i
    cp -r $importWorkspaces/$i/* $federatedWorkspace/src/
}

function federateLocal() {
    cp -r $localWorkspace/* $federatedWorkspace/src/
}

resetWorkDir

stageProjectSource $projectDir $localWorkspace
federateWorkspaces 

installWorkspace $federatedWorkspace $subPath
