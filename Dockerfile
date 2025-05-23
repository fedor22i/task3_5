FROM --platform=$BUILDPLATFORM golang:latest AS builder
ARG TARGETOS
ARG TARGETARCH

WORKDIR /go/src/app
COPY . .
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o task3_5 .

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/task3_5 .
ENTRYPOINT ["/task3_5"]