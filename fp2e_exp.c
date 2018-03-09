#include <stdio.h>
#include <assert.h>
#include <math.h>

#include "fp2e.h"
#include "fpe.h"
#include "mul.h"
#include "scalar.h"

// fp2e_exp and fp2e_sqrt added by David Lazar for Alpenhorn

// Exponentiation
void fp2e_exp(fp2e_t rop, const fp2e_t op, const scalar_t exp)
{
	fp2e_t dummy;
	unsigned int startbit;

	startbit = scalar_scanb(exp);
	fp2e_set(dummy, op);
	fp2e_set(rop, op);
	int i;
	for (i = startbit; i > 0; i--) {
		fp2e_square(rop, rop);
		if (scalar_getbit(exp, i - 1))
			fp2e_mul(rop, rop, dummy);
	}
}

const fp2e_t fp2e_one = {{{1., 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}};
const fp2e_t fp2e_negOne = {{{-1., 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}};
const fp2e_t fp2e_i = {{{0, 1., 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}};

const scalar_t pMinus3Div4 = {0x86172b1b17822599, 0x7b96e234482d6d67, 0x6a9bfb2e18613708, 0x23ed4078d2a8e1fe};
const scalar_t pMinus1Div2 = {0xc2e56362f044b33, 0xf72dc468905adacf, 0xd537f65c30c26e10, 0x47da80f1a551c3fc};

// Sets rop to the square root of a in the GFp2 field (F_{p^2}).
// This is Algorithm 9 from https://eprint.iacr.org/2012/685.pdf
// Assumes p is a prime with p = 3 mod 4, and that a is Minimal.
int fp2e_sqrt(fp2e_t rop, const fp2e_t a)
{
	fp2e_t a1, alpha, a0, x0, b;

	fp2e_exp(a1, a, pMinus3Div4);
	fp2e_mul(alpha, a1, a);
	fp2e_mul(alpha, a1, alpha);

	fp2e_conjugate(a0, alpha);
	fp2e_mul(a0, a0, alpha);

	if (fp2e_iseq(a0, fp2e_negOne)) {
		return 0;
	}

	fp2e_mul(x0, a1, a);
	if (fp2e_iseq(alpha, fp2e_negOne)) {
		fp2e_mul(rop, fp2e_i, x0);
		return 1;
	} else {
		fp2e_add(b, fp2e_one, alpha);
		fp2e_exp(b, b, pMinus1Div2);
		fp2e_mul(rop, b, x0);
		return 1;
	}
}


