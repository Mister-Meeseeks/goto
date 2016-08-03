package baz

import "myProject/foo"
import "zoo/animals"

func Dazzle() string {
	return foo.Talk() + ": " + animals.PickRightCat()
}
