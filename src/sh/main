#!/bin/bash -eu

scriptDir=$(dirname $(readlink -f $0))
export PATH=$PATH:$scriptDir/

if trapHelpMsg $@ ; then
    exit
else
    case $# in
	0)  buildDir=$PWD
	    outputPath=$buildDir;;
	1)  buildDir=$1
	    outputPath=$PWD;;
	2)  buildDir=$1
	    outputPath=$2;;
    esac
fi

. dirLayout

projectDir=$(discoverProject $buildDir)
subPath=$(breakOffBuildSub $projectDir $buildDir)

workDir=$(setupWorkDir $projectDir)
setWorkDirs $workDir

includeProject $projectDir $localSrc
federateWorkspace

installGoTarget $federatedWorkspace $subPath \
    | exportBinaries $outputPath
