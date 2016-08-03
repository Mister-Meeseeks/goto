#!/bin/bash -eu

processUrl=$1

export GOPATH=$remoteDownloads
downloadDir=$remoteDownloads/src/$processUrl

# Go will try to build and fail, so just supress errors here.
function downloadRepo() {
    local processUrl=$1
    go get -d $processUrl 2>/dev/null || true
}

function cleanGitRefs() {
    local gitDir=$1
    if [[ -d $gitDir/.git ]] ; then
	rm -rf $gitDir/.git
    fi
}

downloadRepo $processUrl
cleanGitRefs $downloadDir
echo $downloadDir
