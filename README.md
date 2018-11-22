# scripts

Install dep:

go get github.com/golang/dep
go build

Then move 'dep' to /usr/local/bin

- - - - - - - - - - - - - - - - - - - -

First step:

Copy gaiad & gaiacli to path: /usr/local/bin

Second step:

(Set environment variables)

alias gaiad='gaiad --home /data/.gaiad/'

alias gaiacli='gaiacli --home /data/.gaiacli/'
