
package hello

import "hello/world"

func Msg() string {
	return "Hello " + world.Msg() + "!"
}
