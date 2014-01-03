#!/bin/bash

cd build
vagrant up
vagrant ssh -c "source /vagrant/build_docker_images.sh"
vagrant halt
cd ..
cp build/cnt/cnt-image.tar ./env
cp build/redis/redis-image.tar ./env

