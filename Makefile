IMAGE_NAME=multiarch-test
APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ghcr.io/fedor22i/$(IMAGE_NAME)
VERSION=v1.0
PLATFORMS = linux/amd64 linux/arm64 darwin/amd64 darwin/arm64 windows/amd64

format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

build: format get
	@for plat in $(PLATFORMS); do \
    	GOOS=$${plat%/*} GOARCH=$${plat#*/} \
    	CGO_ENABLED=0 go build -v -o task3_5-$${plat%/*}-$${plat#*/} \
    	-ldflags "-X github.com/fedor22i/task3_5/cmd.appVersion=${VERSION}"; \
    done

image:
	@for plat in $(PLATFORMS); do \
		OS=$${plat%/*}; ARCH=$${plat#*/}; \
		docker build --build-arg TARGETOS=$$OS --build-arg TARGETARCH=$$ARCH .\
		-t ${REGISTRY}/${APP}:${VERSION}-$$OS-$$ARCH; \
	done

push:
	@for plat in $(PLATFORMS); do \
		OS=$${plat%/*}; ARCH=$${plat#*/}; \
		docker push ${REGISTRY}/${APP}:${VERSION}-$$OS-$$ARCH; \
	done

clean:
	rm -rf task3_5*
