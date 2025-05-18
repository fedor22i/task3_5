IMAGE_NAME=multiarch-test
PLATFORMS=linux/amd64 linux/arm64 darwin/amd64 darwin/arm64 windows/amd64
REGISTRY=quay.io/yourorg/$(IMAGE_NAME)
DOCKER_BUILDX=buildx

all: linux arm64 macos windows

linux:
	$(DOCKER_BUILDX) build --platform linux/amd64 -t $(REGISTRY):linux-amd64 --push -f Dockerfile .

arm64:
	$(DOCKER_BUILDX) build --platform linux/arm64 -t $(REGISTRY):linux-arm64 --push -f Dockerfile .

macos:
	$(DOCKER_BUILDX) build --platform darwin/amd64 -t $(REGISTRY):darwin-amd64 --push -f Dockerfile .
	$(DOCKER_BUILDX) build --platform darwin/arm64 -t $(REGISTRY):darwin-arm64 --push -f Dockerfile .

windows:
	$(DOCKER_BUILDX) build --platform windows/amd64 -t $(REGISTRY):windows-amd64 --push -f Dockerfile .

clean:
	@echo "Cleaning up docker images..."
	-docker rmi $(REGISTRY):linux-amd64
	-docker rmi $(REGISTRY):linux-arm64
	-docker rmi $(REGISTRY):darwin-amd64
	-docker rmi $(REGISTRY):darwin-arm64
	-docker rmi $(REGISTRY):windows-amd64
