FROM golang:1.12-alpine3.10 AS build-stage
RUN apk add git
WORKDIR /app
COPY src .
RUN go get
RUN go build

FROM alpine:3.10
COPY --from=build-stage /app/caddy /usr/local/bin/caddy
WORKDIR /app
EXPOSE 80 443 2015
ENTRYPOINT ["caddy"]
