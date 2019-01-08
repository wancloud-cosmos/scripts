 #!/bin/bash

echo "Enter the password:"
read -s password

while true
do
    echo "Delegating ..."

    denom=$(gaiacli query account cosmos16p0uqvts5nvgy4rt5qeljg0e27kq5ay86a0kt3 --chain-id=game_of_stakes_3 --trust-node=true | jq -r '.value.coins[0].denom')
    amount=$(gaiacli query account cosmos16p0uqvts5nvgy4rt5qeljg0e27kq5ay86a0kt3 --chain-id=game_of_stakes_3 --trust-node=true | jq -r '.value.coins[0].amount')

    if [ "$denom" == "STAKE" ]; then
        echo "Current STAKE amount is: "$amount", now delegate them ..."
        echo "gaiacli tx stake delegate --home /data/.gaiacli --validator=cosmosvaloper16p0uqvts5nvgy4rt5qeljg0e27kq5ay8lfmr8z --from=gos-new --chain-id=game_of_stakes_3 --fee=3020photinos --amount="${amount}"STAKE"

        echo "$password" | gaiacli tx stake delegate --async --home /data/.gaiacli --validator=cosmosvaloper16p0uqvts5nvgy4rt5qeljg0e27kq5ay8lfmr8z --from=gos-new --chain-id=game_of_stakes_3 --fee=3020photinos --amount=${amount}STAKE
    fi

    sleep 600
done
