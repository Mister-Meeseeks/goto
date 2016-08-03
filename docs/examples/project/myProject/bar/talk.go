package bar

import "myProject/foo"

func Talk() string {
	return "Kung " + foo.Talk()
}
