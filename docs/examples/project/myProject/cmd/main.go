package main

import "myProject/foo"
import "myProject/bar"
import "fmt"

func main() {
	fmt.Println(foo.Talk())
	fmt.Println(bar.Talk())
}
