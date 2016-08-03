#!/bin/bash -eu

function federateImport() {
    local importName=$1
    cp -r $importSrc/$importName/* $federatedWorkspace/src/
}

function federateQualified() {
    local importName=$1
    cp -r $importSrc/$importName/ $federatedWorkspace/src/$importName
}

function federateLocal() {
    cp -r $localSrc/* $federatedWorkspace/src/
}

for i in $(ls $importSrc/) ; do
    fedetateImport $i
done

for i in $(ls $importSrc/) ; do
    fedetateQualified $i
done

federateLocal


