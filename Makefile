all:
	make deps
	make build

build:
	go build -o build/cnt/cnt
	go vet
	go install

build-docker:
	./build-docker.sh


deps:
	go get github.com/garyburd/redigo/redis
	go get code.google.com/p/go.tools/cmd/vet

todo:
	@grep -n ^[[:space:]]*_[[:space:]]*=[[:space:]][[:alnum:]] *.go || true
	@grep -n TODO *.go || true
	@grep -n FIXME *.go || true
	@grep -n BUG *.go || true

clean:
	go clean