# scripts

@build server
1、Install dep:

`
go get -u github.com/golang/dep
go build
`

2、Install statik:

`
go get -u github.com/rakyll/statik
go build
`

Then set $GOPATH/bin in $PATH or move 'dep' & 'statik' to /usr/local/bin




@execution server

First step:

Copy gaiad & gaiacli to path: /usr/local/bin

Second step:

(Set environment variables)

alias gaiad='gaiad --home /data/.gaiad/'

alias gaiacli='gaiacli --home /data/.gaiacli/'
