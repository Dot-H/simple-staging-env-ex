# syntax=docker/dockerfile:1

## Build
FROM golang:1.19-buster AS build

WORKDIR /app


COPY echo-server/go.mod ./
RUN go mod download

COPY echo-server/*.go ./

RUN go build -o /echo-server

## Deploy
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /echo-server /echo-server

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/echo-server"]
