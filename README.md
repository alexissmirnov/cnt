CNT
===

[![Build Status](https://travis-ci.org/alexissmirnov/cnt.png?branch=master)](https://travis-ci.org/alexissmirnov/cnt)

Cnt is a counter server. Backed by [Redis](http://redis.io).

This code is primarely intended to be a playground to learn and explore some of the concepts and technologies I'm interested in.

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
./cnt-server -port {port-number} -redis {redis-server:redis-port}
```

Build sequence
--------------
- Boot a vagrant box that will be used to build docker images
- Build cnt app on the build box
- Build docker image for redis, cnt go app
- Boot the images to get live containers
- Export containers into .tar files
- Halt vagrant box

- Boot environment boxes
- import docker images
- create autorun config to run docker images


Environment
-----------
- vagrant up



TODO
----
* Add Docker build step

