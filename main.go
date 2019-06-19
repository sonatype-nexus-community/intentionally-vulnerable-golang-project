package main

import (
	"github.com/ethereum/go-ethereum/ethclient"
	"github.com/goharbor/harbor/src/common/utils"
	"log"
)

func main() {
	log.Printf("teasing vulnerable packages...")
	_ = ethclient.Client{}
	_ = utils.Link{}
}
