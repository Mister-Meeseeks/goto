
projectDir=$1

gotoWorkDir=$projectDir/$gotoWorkSubDir/

if [[ -d $gotoWorkDir ]] ; then
    rm -r $gotoWorkDir
fi

setWorkDirs $gotoWorkDir
mkdir -p $localSrc $importSrc $qualifiedSrc $remoteSrc \
    $federatedWorkspace/src/

echo $gotoWorkDir
