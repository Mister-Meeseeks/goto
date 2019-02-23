#!/bin/bash -eu

projectDir=$1

gotoWorkDir=$projectDir/$gotoWorkSubDir/

if [[ -d $gotoWorkDir ]] ; then
    rm -rf $gotoWorkDir
fi

setWorkDirs $gotoWorkDir
mkdir -p $localSrc $importSrc $qualifiedSrc \
    $remoteDownloads $federatedWorkspace/src/

echo $gotoWorkDir
