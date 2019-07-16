package main

import (
	"github.com/ethereum/go-ethereum/ethclient"
	"github.com/goharbor/harbor/src/common/utils"
	// "github.com/gohouse/gorose"
	"github.com/rs/cors"
	"log"
)

func main() {
	log.Printf("teasing vulnerable packages...")
	_ = ethclient.Client{}
	_ = utils.Link{}
	_ = cors.Options{}
	// _ = gorose.Config{}
}
