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

Let's start with a simple Hello World app. First create a new directory for the app

    $ mkdir myApp
    $ cd ./myApp
    
The first step is to create an empty `goto.cfg` file to let goto know where the root of the project
starts:

    $ touch goto.cfg
    
Now in your favorite editor create three files at the following relative paths inside the myApp directory:

*./hello/world/world.go*

    package world
    func Msg() string {
	  return "World"
    }

*./hello/hello.go*:

    package hello
    import "hello/world"
    func Msg() string {
	    return "Hello " + world.Msg() + "!"
    }

*./main/main.go*

    package main
    import "hello"
    import "fmt"
    func main() {
	  fmt.Println(hello.Msg())
    }

Your directory tree will look like this

    .
    ├── goto.cfg
    ├── hello
    │   ├── hello.go
    │   └── world
    │       └── world.go
    └── main.go

Now that you're set up, let's give the goto build system a spin. From inside the myApp directory run

    $ goto . hi
    $ ./hi
    Hello World!
    
Success. We see that goto successfully build an executable binary from our project's main function.
And we never had to set foot in $GOPATH.

