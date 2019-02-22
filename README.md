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
    
## Hello World

Let's start with a simple Hello World app. We have three files spread across different packages:

*world.go*

    package world
    func Msg() string {
	  return "World"
    }

*hello.go*:

    package hello
    import "helloWorld/hello/world"
    func Msg() string {
	    return "Hello " + world.Msg() + "!"
    }

*main.go*

    package main
    import "helloWorld/hello/world"
    import "fmt"
    func main() {
	  fmt.Println(hello.Msg())
    }

Setting up this app with Go's builtin packaging system is a pain. We have to add it to our canonical 
$GOPATH directory and carefully lay out the directory:

    [GOPATH]
      └── src
        └── helloWorld
            ├── cmd
            │   ├── main.go
            └── hello
                ├── hello.go
                └── world
                    └── world.go


