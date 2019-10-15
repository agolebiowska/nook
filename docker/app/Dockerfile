# Build environment
# -----------------
FROM golang:1.13-alpine as build-env

RUN apk update && apk add --no-cache gcc musl-dev git autoconf automake libtool gettext gettext-dev make g++ texinfo curl
WORKDIR /root
RUN wget https://github.com/emcrisostomo/fswatch/releases/download/1.14.0/fswatch-1.14.0.tar.gz
RUN tar -xvzf fswatch-1.14.0.tar.gz
WORKDIR /root/fswatch-1.14.0
RUN ./configure
RUN make
RUN make install

WORKDIR /nook

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -ldflags '-w -s' -a -o ./bin/app ./cmd/app \
    && go build -ldflags '-w -s' -a -o ./bin/migrate ./cmd/migrate


# Deployment environment
# ----------------------
FROM alpine
RUN apk update && apk add --no-cache bash mysql-client

COPY --from=build-env /nook/bin/app /nook/
COPY --from=build-env /nook/bin/migrate /nook/
COPY --from=build-env /nook/migrations /nook/migrations

COPY --from=build-env /nook/docker/app/bin /usr/local/bin/nook/
RUN chmod +x /usr/local/bin/nook/*