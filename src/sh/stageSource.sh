#!/bin/bash -eu

projectDir=$1
workspaceDir=$2

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

plantRootTreeWorkspaces $workspaceDir
mirrorProjectSource $projectDir $workspaceDir
