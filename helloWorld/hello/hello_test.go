package hello

import "testing"

func TestMsg (t *testing.T) {
	if Msg() != "Hello, World!" {
		t.Errorf("Msg does not match")
	}
}

