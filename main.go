package main

import (
	"github.com/gohouse/gorose"
	"github.com/rs/cors"
	"log"
)

func main() {
	log.Printf("teasing vulnerable packages...")
	_ = cors.Options{}
	// _ = gorose.Config{}
}
