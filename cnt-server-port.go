package main

import (
	"flag"
	"fmt"
	"net/http"
)

var counters = map[string]int{}

var port int

func init() {
	const (
		defaultPort = 5379
	)
	flag.IntVar(&port, "port", defaultPort, fmt.Sprintf("Accept connections on the specified port, default is %d", defaultPort))
}

func handler(rw http.ResponseWriter, req *http.Request) {
	c, _ := counters[req.URL.Path]

	if req.Method == "GET" {
		fmt.Fprintf(rw, "%d", c)
	} else if req.Method == "PUT" {
		counters[req.URL.Path] = c + 1
	}
}

func main() {
	flag.Parse()

	fmt.Printf("Listening on port %d.\n", port)

	http.HandleFunc("/", handler)
	http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
}
