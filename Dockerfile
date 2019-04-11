FROM golang:1.11.5 as builder

RUN mkdir -p /build
WORKDIR /build
RUN useradd -u 10001 app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM scratch

COPY --from=builder /build/main /main
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs /etc/ssl/certs
USER app

EXPOSE 8080
CMD ["/main"]
