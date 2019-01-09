#!/bin/bash

echo "Enter the password:"
read -s PWD

CHAIN_ID="game_of_stakes_3"
ADDR_VALIDATOR="cosmosvaloper16p0uqvts5nvgy4rt5qeljg0e27kq5ay8lfmr8z"
FROM="gos-new"
FEE="120"

while true
do
    echo "Delegating($(date '+%Y-%m-%d %H:%M:%S')) ..."

    DENOM=$(gaiacli query account cosmos16p0uqvts5nvgy4rt5qeljg0e27kq5ay86a0kt3 --chain-id=game_of_stakes_3 --trust-node=true | jq -r '.value.coins[0].denom')
    AMOUNT=$(gaiacli query account cosmos16p0uqvts5nvgy4rt5qeljg0e27kq5ay86a0kt3 --chain-id=game_of_stakes_3 --trust-node=true | jq -r '.value.coins[0].amount')

    if [ "$DENOM" == "STAKE" ]; then
        echo "Current STAKE amount is: "$AMOUNT", now delegate them ..."
        echo "$PWD" | gaiacli tx stake delegate --async --home /data/.gaiacli --validator=${ADDR_VALIDATOR} --from=${FROM} --chain-id=${CHAIN_ID} --fee=${FEE}photinos --amount=${AMOUNT}STAKE
    fi

    sleep 600
done
