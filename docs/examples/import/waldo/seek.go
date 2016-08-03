package waldo

import "myProject/bar"

func Seek() string {
	return "... " + bar.Talk() + "... Found him"
}
