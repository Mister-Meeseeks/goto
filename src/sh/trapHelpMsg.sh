#!/bin/bash -eu

cmdArgs=$@

function isHelpCmd() {
    [[ $# -gt 0 ]] && isHelpWord $1 
}

function isHelpWord() {
    local word=$1
    [[ $word == "help" || $word == "-help" || $word == "--help" \
	|| $word == "Help" || $word == "HELP" ]]
}

if ! isHelpCmd $@ ; then
    exit 1
fi

cat <<EOF

goto is a tool for simplifying go's package management system.

Usage:

   goto
   goto [build dir]
   goto [output path] [build dir]

Where:

   build dir:      The directory containing the golang code to compile into a 
                   binary. If using a project structure, a parent directory at
                   the root of the project has a goto.cfg file. If empty default
                   is the current working directory.

   output path:    Directory or named path where the compiled binary is written.
                   If empty default is the build directory.

   For more information check the README.md and docs in the project repository:
   github.com/Mister-Meeseeks/goto/

EOF
