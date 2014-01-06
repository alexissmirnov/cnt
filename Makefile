all:
	make deps
	make build

build:
	go build -o build/cnt
	go vet
	go install

build-docker:
	./build-docker.host.sh


deps:
	go get github.com/garyburd/redigo/redis
	go get code.google.com/p/go.tools/cmd/vet

todo:
	@grep -n ^[[:space:]]*_[[:space:]]*=[[:space:]][[:alnum:]] *.go || true
	@grep -n TODO *.go || true
	@grep -n FIXME *.go || true
	@grep -n BUG *.go || true

clean:
	rm ./build/Vagrantfile
	# FIXME Vagrant won't mount /vagrant filesystem until rebooted, emitting the following error:
	# Use 'vagrant halt' followed by 'vagrant up' to ensure
	# 
	# rm -rf ./build/.vagrant
 	# rm ./build/*.tar
 	# rm -rf ./build/*.docker

