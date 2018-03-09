Originally by https://github.com/vuvuzela/crypto, but had to fix it up to work
with windows and modern Go.

Performance (2.3ghz haswell)

AMD64 asm:
```
$ go test -run=Bench -bench=.
goos: windows
goarch: amd64
BenchmarkUnmarshalG2      300000              5333 ns/op (slow because cgo ffi)
BenchmarkScalarMultG2       3000            395953 ns/op
BenchmarkPairing            2000           1100278 ns/op
```

That's about 1000 pairings/sec on a single core.

This library makes sense only on amd64+cgo builds.

When no AMD64 is available, the library will fall back to C, but it will be very
slow. At that point you might want to use build flags to package to
http://github.com/cloudflare/bn256 which is 2x slower on amd64, but much faster
on anything else. And it doesn't need cgo. 
