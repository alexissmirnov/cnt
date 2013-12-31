// TODO: add description

package main

import (
	"flag"
	"fmt"
	"github.com/garyburd/redigo/redis"
	"net/http"
)

var exitCode int
var redisConnection redis.Conn
var counters = map[string]int{}

var port int

func init() {
	const (
		defaultPort = 5379
	)
	flag.IntVar(&port, "port", defaultPort, fmt.Sprintf("Accept connections on the specified port, default is %d", defaultPort))
}

var redisServerAddress string

func init() {
	flag.StringVar(&redisServerAddress, "redis", "", "ip:port of the Redis server")
}

func handler(rw http.ResponseWriter, req *http.Request) {
	var n int

	switch req.Method {
	case "GET":
		n, _ = redis.Int(redisConnection.Do("GET", req.URL.Path[1:]))
		fmt.Fprintf(rw, "%d", n)
	case "POST":
		n, _ = redis.Int(redisConnection.Do("INCR", req.URL.Path[1:]))
		fmt.Fprintf(rw, "%d", n)
	}
}

func connectRedis(address string) redis.Conn {
	c, err := redis.Dial("tcp", address)
	if err != nil {
		fmt.Println(err)
	}

	return c
}

func main() {
	flag.Parse()

	fmt.Printf("Listening on port %d.\n", port)
	fmt.Printf("Using Redis on %s.\n", redisServerAddress)

	redisConnection = connectRedis(redisServerAddress)

	http.HandleFunc("/", handler)
	http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
}
