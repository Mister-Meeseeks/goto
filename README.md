# goto
Fix golang's broken packaging system

## Under Construction

Project is not ready yet. Check back later.

## Motivations

Go enforces a very opinionated structure on how packages are organized. Unfortunately it's mostly a bad opinion. Go uses the concept of a global workspace. Each package's importable locaction is its relative path from workspace root.This results in several major design flaws.

First, namespaces are broken. To use a golang namespace you place the package directories in the same parent directory. E.g. ```mammals/aquatic/``` and ```mammals/primates/```. But the point of a namespace is that an object knows how to resolve relative object names within the same space. I.e. ```mammals/primates/gorilla.go```should be able to call```import 'aquatic'```. Instead if has to fully specify ```import 'mammals/aquatic'```. 

What is the point of a namespace if it doesn't relative resolution? With Go, basically every package exists in the same flat universal namespace. Regardless of namespace membership resolution is only possible with a fully specified path. The parent  directory isn't a namespace insamuch as just a prefix. The problem only gets worse with nested namespaces. Consider ```biology/zoology/vertebrates/mammals/primates```. That's a mouthful of highly coupled boilerplate on every import  directive.

This leads to the second major design flaw: remote import paths. Unless you're using a monolithic repo which also happens to be your $GOPATH workspace, remote imports are basically required. The Go workspace must contain a sub-directory tree of the  form src/[repository_url]/[package_path_in_repository]. Say we want the ```mammals/primates``` package from the Gtihub repo ````zookeeper/species-catalog```. Our workspace must contain the ```github.com/zookeeper/species-catalog/mammals/primates``` directory. 

Worse, every other package that uses this package must call ```import 'github.com/zookeeper/species-catalog/mammals/primates'``` Even sister packages from within the same repo. What if we want to move the repo to a different server? Or change the Github user? What if we need to freeze the package at a given version or branch? That's going to result in a painful and error-prone manual process of chaning the import directive in every single .go file which uses that package. The problem comes down to the individual URLs of package repos is part of config, not source. At most repo sources should be specified once, at a canonicallocation in a meta-package file.

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

Go's remote repository convention means the package is now located at ```github.com/zookeeper/src/v1.0/go/mammals/primates```. The ```src/v1.0/go`` sub-string is just pure organizational book-keeping from the repo's owner standpoint. But now every single package consumer has to be intimately familiar with the repository structure and tediously include this boilerplate at every import directive.
