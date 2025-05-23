FROM quay.io/projectquay/golang:1.24 AS builder

WORKDIR /go/src/app
COPY . .
RUN make build

FROM quay.io/projectquay/golang:1.24

WORKDIR /
COPY --from=builder /go/src/app/task3_5 .
ENTRYPOINT ["/task3_5"]