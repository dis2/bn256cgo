// +build !amd64 noasm

package bn256
// #cgo CFLAGS: -std=c99 -O3 -fomit-frame-pointer
// #cgo LDFLAGS: -lm
import "C"
