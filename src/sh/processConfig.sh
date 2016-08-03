#!/bin/bash -eu

configDir=$1

function processText() {
    while read line ; do
	processLine "$line"
    done
}

function processLine() {
    local line=$1
    if isActionableLine "$line" ; then
	processValidLine "$line"
    fi
}

# Ignore comments and empty lines
function isActionableLine() {
    local line=$1
    [[ $(cut -b 1 <(echo $line)) != '#' && \
	! -z "$line" ]]
}

function processValidLine() {
    local line=$1
    local cmdType=$(echo $line | cut -d ' ' -f 1)
    local cmdVal=$(echo $line | cut -d ' ' -f 2)
    local cmdQual=$(echo $line | cut -d ' ' -f 3)
    processFields $cmdType $cmdVal $cmdQual
}

function processFields() {
    local cmdType=$1; shift
    if [[ $cmdType == "import" ]] ; then
	importDirectory $@
    elif [[ $cmdType == "remote" ]] ; then
	importRemote $@
    fi
}

function importDirectory() {
    if [[ $# -gt 1 ]] ; then
	importQualified $@
    else
	importDirect $@
    fi
}

function importDirect() {
    local projectDir=$1
    includeProject $projectDir $importsDir
}

function importQualified() {
    local projectDir=$1
    local qualifiedSub=$2
    local qualifiedDir=$qualifiedSrc/$qualifiedSub
    mkdir -p $qualifiedDir
    includeProject $projectDir $qualifiedDir
}

function importRemote() {
    local projectUrl=$1; shift
    srcDir=$(retrieveRemote $projectUrl)
    importDirectory $srcDir $@
}

cat $configDir | processText
