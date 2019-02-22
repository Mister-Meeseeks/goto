# goto

An Alternative build and package system for Go. Never deal with $GOPATH again. Take back your freedom to 
layout projects however you want. Stop hardcoding package URLs in source code. 

goto wraps the Go package system in a way that adds the following enhancements:

* Build multi-package projects in place, at any location, without setting $GOPATH
* Specify package URLs once in a config file- not every single source file
* Import packages from arbitrary locations in the filesystem
* Import from a repo sub-directory just as easily as a repo.
* Import packages from by just specifying subdirectory
* Alias package names

## Motivations

Tl;dr: Golang's namespace and import system sucks. Skip this section if you're already convinced.

Go enforces an opinionated package organization structure. Unfortunately that opinion is dead wrong. Golang's build system is rooted in a global workspace. To import an external package, you place it in the global workspace and point to its directory tree node. This results in several major design flaws.

First, namespaces are fundamentally broken. To share a golang namespace keep the package directories within the same parent directory. E.g. ```mammals/aquatic/``` and ```mammals/primates/```. ```primates``` and ```aquatic``` are both children of ```mammals```. If ```mammals/primates/gorilla.go``` should be able to call ```import 'aquatica```. However Go's global workspace build system requires a fully qualified ```import 'mammals/aquatic'```. 

What is the point of nested namespace if they don't support relative resolution? In the global workspace, every package exists in an effectively flat universal namesapce. The parent directory isn't a namespace insamuch as just a prefix. The problem only gets worse with deeper nesting. Consider ```biology/zoology/vertebrates/mammals/primates```. That's a mouthful of highly coupled boilerplate on every import directive.

This leads to the second major design flaw: remote import paths. To organize large codebases you either must use a monolithic repo OR make use of remote imports. To do so, the Go workspace must contain a sub-directory tree of the form ```src/[repository_url]/[package_path_in_repository]```. Say we want the ```mammals/primates``` package from the Gtihub repo ````zookeeper/species-catalog```. Our workspace must contain a ```github.com/zookeeper/species-catalog/mammals/primates``` directory tree. 

Worse, every other package that uses this package must call ```import 'github.com/zookeeper/species-catalog/mammals/primates'``` Even sister packages from within the same repo. What if we want to move the repo to a different server? Or change the Github user? What if we need to freeze the package at a given version or branch? That's going to result in a painful and error-prone manual process of chaning the import directive in every single .go file which touches the package. 

Finally, Go enforces a rigid structure on any repository that wants to use Go code. Since the relative path of the Go project folder becomes the namespace, Go code must basically be kept at repo root. Otherwise the sub-directory tree clutters the  namespace and import directive. E.g. consider a multi-language repo structued like:

```
+== _config.yml
+== _docs
+== _cfg
+== _tests
+== src
|   +== v1.0
|   |   +== js
|   |   +== cpp
|   |   +== go
|   |   |   +== mammals/primates
```

Go's remote repository convention means the package is now located at ```github.com/zookeeper/src/v1.0/go/mammals/primates```. The ```src/v1.0/go`` sub-string is pure organizational book-keeping. But now every single package consumer has to be intimately familiar with the repository structure and tediously include this boilerplate at every import directive.
