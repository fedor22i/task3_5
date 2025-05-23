FROM golang:1.24 AS builder

WORKDIR /go/src/app
COPY . .
RUN make build

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/task3_5 .
ENTRYPOINT ["/task3_5"]