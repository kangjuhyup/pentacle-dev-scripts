#!/bin/sh

echo "\033[43;31mStart add validator...\033[0m"
node_list=$(ls | grep node-*)
node_count=$(echo "$file_list" | wc -l)
node_folder="node-$node_count"
mkdir -p node-$node_folder/data/keystore

addValidator="addValidator"
npx quorum-genesis-tool --validators 1 --members 0 --bootnodes 0 --outputPath $addValidator

cp addValidator/*/validator0/nodeKey* addValidator/*/validator0/address node_folder/data
cp addValidator/*/validator0/account* node_folder/data/keystore

address=$(grep -o '"address": *"[^"]*"' ./$node_folder/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')

echo "istanbul.propse("0x$address",true);" | geth attach node-0/data/geth.ipc

cp node-0/static-nodes.json $node_folder/data
cp node-0/genesis.json $node_folder/data

