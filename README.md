# scripts

@build server

1、Install dep:

`
go get -u github.com/golang/dep ...
`

2、Install statik:

`
go get -u github.com/rakyll/statik ...
`

Then append $GOPATH/bin to $PATH or move 'dep' & 'statik' commands to /usr/local/bin

3、Run

`
cd ~
`

`
git clone https://github.com/wancloud-cosmos/scripts.git
`

`
./scripts/cosmos/auto_push.sh
`


@execution server

1、Set environment variables in ~/.profile

`
alias gaiad='gaiad --home /data/.gaiad/
`

`
alias gaiacli='gaiacli --home /data/.gaiacli/
`

2、Run

`
cd ~
`

`
git clone https://github.com/wancloud-cosmos/scripts.git
`

(validator node)

`
./scripts/cosmos/start_validator.sh gaia-9001
`

`
./scripts/cosmos/restart.sh validator
`

(sentry node)

`
./scripts/cosmos/start_sentry.sh gaia-9001
`

`
./scripts/cosmos/restart.sh sentry
`


@cron

'crontab -e' then edit:

`
*/1 * * * * ~/scripts/cosmos/check.sh >> /data/cron.log
`
