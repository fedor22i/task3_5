FROM quay.io/projectquay/golang:latest AS builder

WORKDIR /go/src/app
COPY . .
RUN make build

FROM quay.io/projectquay/golang:latest

WORKDIR /app
COPY --from=builder /app/main .
ENTRYPOINT ["./main"]