FROM golang:alpine3.23 as builder
WORKDIR /app
COPY /app /app/
RUN go build -o main

FROM alpine:3
COPY --from=builder /app/main /usr/local/bin/main
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/main"]
