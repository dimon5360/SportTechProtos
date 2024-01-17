#!/bin/bash

case "${OSTYPE}" in
    darwin*)    protoc=protoc;;
    linux*)     protoc=protoc;;
    *Msys)      protoc=D:/projects/protoc/bin/protoc.exe;;
esac

${protoc} --version

go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

export PATH="$PATH:$(go env GOPATH)/bin"

rm -rf gen/go/*.pb.go


${protoc} \
  --go_out=./gen/go  --go_opt=paths=source_relative \
  --go-grpc_out=./gen/go  --go-grpc_opt=paths=source_relative \
  proto/*.proto
