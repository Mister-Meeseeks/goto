#!/bin/bash -eu

scriptDir=$(dirname $(readlink -f $0))
buildDir=$PWD
outputPath=$buildDir

export gotoCfgBase=goto.cfg
export PATH=$PATH:$scriptDir/
. dirLayout

projectDir=$(discoverProject $buildDir)
subPath=$(breakOffBuildSub $projectDir $buildDir)

workDir=$(setupWorkDir $projectDir)
setWorkDirs $workDir
includeProject $projectDir $localSrc

federateWorkspace
installGoTarget $federatedWorkspace $subPath \
    | exportBinaries $outputPath
