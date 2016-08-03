#!/bin/bash -eu

function federateImport() {
    local importDir=$1
    cp -r $importDir/* $federatedWorkspace/src/
}

function federateQualified() {
    local importDir=$1
    cp -r $importDir $federatedWorkspace/src/
}

function federateLocal() {
    cp -r $localSrc/* $federatedWorkspace/src/
}

for i in $(ls $importSrc/) ; do
    fedetateImport $importSrc/$i
done

# We must federate the src directory unqualified as well, so that's
# it can reflexively access its own packages.
for i in $(ls $qualifiedSrc/) ; do
    federateImport $qualifiedSrc/$i
    federateQualified $qualifiedSrc/$i
done

federateLocal


