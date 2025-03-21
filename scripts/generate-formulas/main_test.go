package main

import "testing"

func TestValidatePanic(t *testing.T) {
	defer func() {
		if r := recover(); r == nil {
			t.Errorf("The code did not panic, when it should have")
		}
	}()

	s := &Shas{}
	s.Validate()
}
func TestValidateNoPanic(t *testing.T) {
	defer func() {
		if r := recover(); r != nil {
			t.Errorf("The code panicked, when it should not have")
		}
	}()

	s := &Shas{
		Tag:         "v1.0.0",
		Version:     "1.0.0",
		DarwinAmd64: "5048e31b6aa912e284b72d6087af88204102d814c066af63f210a1f48504beff",
		DarwinArm64: "0fea948d10091a8442c97d872eff7c81ae73d522415118d6ce81bcb2c0f35fa5",
		LinuxAmd64:  "e08b5c83558efc8e2e3a273f6166c93e3f7d0f8daa98557f2eb05c691480cf66",
		LinuxArm64:  "7360b4c12ffe789e8b12030b164c45299d4514f063d4c7b87498d2aa89c5b0af",
	}

	s.Validate()
}
