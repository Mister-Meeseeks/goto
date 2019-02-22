# goto

## Under Construction

Check back later

## Intro

An Alternative build and package system for Go. Never deal with $GOPATH again. Take back your freedom to 
layout projects however you want. Stop hardcoding package URLs in source code. 

goto wraps the Go package system in a way that adds the following enhancements:

* Build multi-package projects in place, at any location, without setting $GOPATH
* Specify package URLs just once in a config file
* Import from any location in the filesystem
* Alias package imports
* Flexible repo structuring. 
* Easy multi-project or multi-language repos.

## Quickstart

Grab the git repo and step inside. Run the following shell commands:

    git clone https://github.com/Mister-Meeseeks/goto.git
    cd ./goto
    
The goto executable is directly accessible from the repo, you can verify with:

    ./goto --help
    
To install to the Linux system environment run:

    sudo ./install.sh
    
If you don't have sudo access or want to install to an alternative location pass a target directory
as an argument. (Preferably one in your environment's $PATH). For example:

    ./install ~/local/bin/
    
