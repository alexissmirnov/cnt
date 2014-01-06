#!/bin/bash

mkdir build

# This script launches the build VM

cp Vagrantfile.build ./build/Vagrantfile

# Docker needs the Dockerfile to be in it's own directory, thus we define 
# redis.docker and cnt.docker as dirctories and out Dockerfile in it.
# The reason I copy the directory to be under ./build is because Dockerfile uses "ADD . /bin" instruction
# that will copy the contents of the directory there Dockerfile is located and will exposed it as /bin 
# inside the Docker container
cp -r ./redis.docker ./build
cp -r ./cnt.docker ./build

cd build
vagrant up

# Produce the cnt build that will be placed into the cnt docker container
vagrant ssh -c "cd /vagrant && go build -o ./build/cnt.docker/cnt"


# Launch the build VM and run the build script in it
vagrant ssh -c "source /vagrant/build-docker.guest.sh"
vagrant halt
cd ..



