// Copyright 2016 The Alpenhorn Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package bn256

import (
	"crypto/rand"
	"testing"
)

func TestMulCofactor(t *testing.T) {
	for i := 0; i < 100; i++ {
		msg := make([]byte, 64)
		rand.Read(msg)

		pt := hashToTwistPoint(msg)

		g := new(twistPoint).Mul(pt, Order)
		if g.IsInfinity() {
			t.Fatal("did not expect point to be in subgroup")
		}

		pt.Mul(pt, twistCofactor)
		g = new(twistPoint).Mul(pt, Order)
		if !g.IsInfinity() {
			t.Fatal("expecting point to be in subgroup after multiplying by cofactor")
		}
	}
}
