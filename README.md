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
    
## Install
    
Default install is to the Linux system environment run:

    sudo ./install.sh
    
By default the executable is written to `/usr/local/bin/`. If you don't have sudo 
access or want to install to an alternative location pass a target directory
as an argument. (Preferably one in your environment's $PATH). For example:

    ./install.sh ~/local/bin/
    
When installing to a custom path this way, the binary links back to the scripts to
the repository itself. Therefore make sure to clone the git repo in a location that
won't be moved or deleted. 

To avoid this you can also specify a location to install the underlying scripts needed
by the executable. Just call install with two positional arguments. The first is the 
location to store the backend scripts. The second the binary path, like above.
    
    ./install.sh ~/local/scripts ~/local/bin/
    
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

## Command Line Interface

The goto exectuable has a very straightforward command line interface. The easiest way to invoke it is
with no arguments: 

    $ goto

It builds the current working directory and outputs any compiled binaries to that same directory. 
Any package directory in a goto project tree can be built passing its relative or absolute path as the
positional argument:

    $ goto ~/myProject/foo/bar/

That builds the `foo/bar` package underneath the goto project at `~/myProject`. Compiled binaries are
by default output to the current working directory. But that can be changed with the -o flag:

    $ goto -o ./bin/ ~/myProject/foo/bar/
    
Will do the same as above but export the compiled binaries (if any) to `./bin/`

## Project Tree

The directory tree for a goto project is defined by the precense of a `goto.cfg` file at the root.
When the goto command builds a package directory, it sequentially searches through the parent directories
of the target until it finds the project root. 

Within the project all packages are visible based on their relative path inside the tree. For the 
following project tree

## goto.cfg

### Imports

### Alias

## .goto Project Workspace

## Exporting Packages

## Build Modes

### Test

### Build

### Build Flags

### Go Commands

## Comparison to Go Modules

* No aliasing
* Modules must declare canonical location
* goto compatible with all Go versions
* No SemVer problems
* No incompatibility issues with import or export by non-modules

