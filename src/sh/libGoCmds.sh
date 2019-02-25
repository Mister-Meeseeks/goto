
# Resolves certain "special" package names that we need to rename to prevent
# various go-specific error conditions.
function sanitizePackage() {
    echo "$1" \
        | sanitizeEmpty \
        | sanitizeCmdDir
}

# The empty string is not a valid Go package name. So we alias the package (if
# any) in the project root to 'root'
function sanitizeEmpty() {
    sed "s+^$+root+"
}

# By convention "cmd" at the root is frequently used to build binaries, but
# never exported as an external package. Yet to compile it still needs a package
# name. Since cmd is a package in the standard library, any code in the project
# cmd/ will conflict by default. Therefore we alias these package to "root/cmd"
function sanitizeCmdDir() {
    sed "s+^cmd+root/cmd+"
}

# Want to convert `go test` type arguments of the form a/b/... to their intended
# package directory. I.e. drop '...' to resolve a package path
function maskGoWilds() {
    echo "$1" \
        | sed 's+^[.][.][.]$+./+' \
        | sed 's+[.][.][.]$++'
}

function addBackGoWilds() {
    local origArg="$1"
    local subPath="$2"
    local goWild=$(whatGoWild "$origArg")
    echo "${subPath}${goWild}" \
         | sanitizeRootWilds
}

function sanitizeRootWilds() {
    sed "s+^/+./+"
}

function whatGoWild() {
    if (echo "$1" | egrep -q "/[.][.][.]$") ; then
        echo "/..."
    elif (echo "$1" | egrep -q "[.][.][.]$") ; then
        echo "..."
    else
        echo ""
    fi
}

function fileToPackage() {
    local path="$1"
    if [[ -e "$path" && ! -d "$path" ]] ; then
        dirname "$path" | dropDirTrail
    else
        echo "$path" | dropDirTrail
    fi
}

function dropDirTrail() {
    sed "s+/^++"
}
