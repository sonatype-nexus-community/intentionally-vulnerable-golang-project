package main

import (
	"encoding/base64"
	"fmt"

	"golang.org/x/crypto/chacha20"
)

func main(){
	cha20, err := chacha20.HChaCha20([]byte("chachachachachachachachachacha12"), []byte("slideslideslide1"))
	fmt.Println(fmt.Sprintf("Doing the cha cha slide : %v but might have errored : %v", base64.StdEncoding.EncodeToString(cha20), err))

	fmt.Println("HI I'M INTENTIONALLY USING VULNERABLE LIBS")
}
