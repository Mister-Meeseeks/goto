package main

import "fmt"
import "hideNSeek/waldo"
import "hideNSeek/fred"

func main() {
	fmt.Println("Let's play hide-n-seek")
	fmt.Println(fred.Hide())
	fmt.Println(waldo.Seek())
}
