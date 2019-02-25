package world

import "testing"

func TestMsg (t *testing.T) {
	if Msg() != "World" {
		t.Errorf("Msg does not match")
	}
}

