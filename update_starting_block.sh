#! /bin/bash

# Get current block number
getBlockNumber() {
    rpc=http://127.0.0.1:8545

	# Get the latest block number from the node
	output=$(curl $rpc -s -X POST -H "Content-Type: application/json" --data '{"method":"eth_blockNumber","params":[],"id":1,"jsonrpc":"2.0"}')

	# Extract the hexadecimal number using jq and remove the surrounding quotes
	hex_number=$(echo $output | jq -r '.result')

	# Convert the hexadecimal to decimal
	block_number=$(echo $((${hex_number})))

	# Return the block number by echoing it
	echo "$block_number"
}

#
CURR_BLK=$(getBlockNumber)
echo "Current Block: ${CURR_BLK}"

#
TARGET_FILE=".env"
echo "Target File: ${TARGET_FILE}"
if [ ! -e $TARGET_FILE ]; then
    echo "Target file not found."
    exit 2
fi

if [ $CURR_BLK == 0 ]; then
    echo "Disable PROVER_STARTING_BLOCK_ID."
    sed -i -e 's/^#PROVER_STARTING_BLOCK_ID/PROVER_STARTING_BLOCK_ID/' $TARGET_FILE
    sed -i -e 's/^PROVER_STARTING_BLOCK_ID/#PROVER_STARTING_BLOCK_ID/' $TARGET_FILE
else
    STARTING_BLK=$(( $CURR_BLK - 100 ))
    echo "Set PROVER_STARTING_BLOCK_ID to ${STARTING_BLK}"
    sed -i -e 's/^#PROVER_STARTING_BLOCK_ID/PROVER_STARTING_BLOCK_ID/' $TARGET_FILE
    sed -i -e "s/^PROVER_STARTING_BLOCK_ID.*/PROVER_STARTING_BLOCK_ID=${STARTING_BLK}/" $TARGET_FILE
fi
