# goto

An Alternative build and package system for Go. Never deal with $GOPATH again. Take back your freedom to 
layout projects however you want. Stop hardcoding package URLs in source code. 

goto wraps the Go package system in a way that adds the following enhancements:

* Build multi-package projects in place, at any location, without setting $GOPATH
* Specify package URLs just once in a config file
* Import from any location in the filesystem
* Namespace package names based on subdirectory
* Alias package names

## Quickstart

Grab the git repo and step inside. Run the following shell commands:

    git clone https://github.com/Mister-Meeseeks/goto.git
    cd ./goto
    
The goto executable is directly accessible from the repo, you can verify with:

    ./goto --help
    
To install to the Linux system environment run:

    sudo ./install.sh
    
That installs to /usr/local/bin/. To install to an alternative location, or if you don't have sudo access,
pass an install directory (preferably in your $PATH) to as an argument to the install script. For example:

    ./install ~/local/bin/
    
