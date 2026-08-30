FROM golang:alpine3.23 AS builder
WORKDIR /app
COPY app/ ./
ENV CGO_ENABLED=0
RUN go build -o main .

FROM alpine:3
RUN adduser -D -H -u 65532 appuser
COPY --from=builder /app/main /usr/local/bin/main
USER 65532:65532
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/main"]
