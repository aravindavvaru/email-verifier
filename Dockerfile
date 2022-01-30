FROM golang:1.16-alpine

USER root
RUN mkdir /build
WORKDIR /build

RUN go clean -modcache
RUN apk add --no-cache git

RUN export GO111MODULE=on
RUN go get github.com/aravindavvaru/email-verifier
RUN cd /build && git clone https://github.com/aravindavvaru/email-verifier.git

RUN cd /build/email-verifier && go build cmd/apiserver/main.go

EXPOSE 8080

ENTRYPOINT [ "/build/email-verifier/main" ]