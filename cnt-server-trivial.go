package main

import (
	"fmt"
	"net/http"
)

var counters = map[string]int{}

func handler(rw http.ResponseWriter, req *http.Request) {
	c, _ := counters[req.URL.Path]

	if req.Method == "GET" {
		fmt.Fprintf(rw, "%d", c)
	} else if req.Method == "PUT" {
		counters[req.URL.Path] = c + 1
	}
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
