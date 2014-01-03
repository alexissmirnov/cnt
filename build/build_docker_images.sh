#!/bin/bash

docker build -t alexissmirnov/cnt:redis-image /vagrant/redis

#################### Redis service

# 
#
# $docker images
# REPOSITORY            TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
# alexissmirnov/redis   latest              693348bdcaa4        15 minutes ago      297.2 MB
# ubuntu                quantal             b750fe79269d        9 months ago        175.3 MB

LATEST_IMAGE=`docker images | grep redis-image | awk -F" " '{print ""$3""}'`

DOCKER_CONTAINER=`docker run -d $LATEST_IMAGE /bin/start_redis.sh`

docker export $DOCKER_CONTAINER > /vagrant/redis/redis-image.tar

docker stop $DOCKER_CONTAINER


#################### GO runtime


docker build -t alexissmirnov/cnt:cnt-image /vagrant/cnt

# 
#
# $docker images
# REPOSITORY            TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
# alexissmirnov/redis   latest              693348bdcaa4        15 minutes ago      297.2 MB
# ubuntu                quantal             b750fe79269d        9 months ago        175.3 MB

LATEST_IMAGE=`docker images | grep cnt-image | awk -F" " '{print ""$3""}'`

DOCKER_CONTAINER=`docker run -d $LATEST_IMAGE /bin/cnt -redis 127.0.0.1:6379`

docker export $DOCKER_CONTAINER > /vagrant/cnt/cnt-image.tar

docker stop $DOCKER_CONTAINER

