#!/bin/bash -eu

function federateSource() {
    local srcRootDir=$1
    for i in $(ls $srcRootDir/) ; do
	cp -r $srcRootDir/$i $federatedWorkspace/src/
    done
}

# Imports each sub-directory into the top-level of the global namespace
function federateSubSources() {
    local srcRootDir=$1
    for i in $(ls $srcRootDir/) ; do
	federateSource $srcRootDir/$i
    done
}

# We must federate the src directory unqualified as well, so that's
# it can reflexively access its own packages.
for i in $(ls $qualifiedSrc/) ; do
    federateSource $qualifiedSrc/$i
done

# Invocation occurs in reverse order of global namespace precedence
federateSubSources $qualifiedSrc
federateSource $qualifiedSrc
federateSource $importSrc
federateSource $localSrc


