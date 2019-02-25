
export gotoCfgBase=goto.cfg
export gotoWorkSubDir=.goto

function setWorkDirs() {
    local workDir=$1
    export localSrc=$workDir/local/
    export importSrc=$workDir/import/
    export qualifiedSrc=$workDir/qualified/
    export remoteDownloads=$workDir/remote/
    export federatedWorkspace=$workDir/federated
}

export -f setWorkDirs
