CNT
===

Cnt is a counter server. Backed by [Redis](http://redis.io).

This code is primarely intended to be a playground to learn and explore some of the concepts ni distributed systems I'm interested in.

API
---
```
PUT http://server:port/{counter-name}
```
Increments the counter. Returns the new value. Uses Redis INCR command

```
GET http://server:port/{counter-name}
```
Returns the current value of the counter. Uses Redis GET command.


Running the server
------------------

```
./cnt-server -port {port-number}
```

TODO
----

* Add Vagrantfile that deploys redis and cnt-server on CoreOS with Docker.

