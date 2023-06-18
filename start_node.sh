#!/bin/sh

echo "\033[43;31mStart 4validators...\033[0m"
config=ignore

chainId=47

echo "\033[43;31mrun node-0...\033[0m"
address=$(grep -o '"address": *"[^"]*"' ./node-0/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
touch node-0/node.log
nohup geth --datadir node-0/data \
    --networkid $chainId --nodiscover --verbosity 4 \
    --syncmode full \
    --istanbul.blockperiod 1 --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22000 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32000 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --unlock $address --allow-insecure-unlock --password node-0/data/keystore/accountPassword \
    --port 30300 > ./node-0/node.log 2>&1 &

echo "\033[43;31mrun node-1...\033[0m"
address=$(grep -o '"address": *"[^"]*"' ./node-1/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
touch node-1/node.log
nohup geth --datadir node-1/data \
    --networkid $chainId --nodiscover --verbosity 4 \
    --syncmode full \
    --istanbul.blockperiod 1 --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22001 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32001 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --unlock $address --allow-insecure-unlock --password node-1/data/keystore/accountPassword \
    --port 30301 > ./node-1/node.log 2>&1 &

echo "\033[43;31mrun node-2...\033[0m"
address=$(grep -o '"address": *"[^"]*"' ./node-2/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
touch node-2/node.log
nohup geth --datadir node-2/data \
    --networkid $chainId --nodiscover --verbosity 4 \
    --syncmode full \
    --istanbul.blockperiod 1 --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22002 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32002 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --unlock $address --allow-insecure-unlock --password node-2/data/keystore/accountPassword \
    --port 30302 > ./node-2/node.log 2>&1 &

echo "\033[43;31mrun node-3...\033[0m"
address=$(grep -o '"address": *"[^"]*"' ./node-3/data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
touch node-3/node.log
nohup geth --datadir node-3/data \
    --networkid $chainId --nodiscover --verbosity 4 \
    --syncmode full \
    --istanbul.blockperiod 1 --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port 22003 --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port 32003 --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --unlock $address --allow-insecure-unlock --password node-3/data/keystore/accountPassword \
    --port 30303 > ./node-3/node.log 2>&1 &

echo "\033[43;31mStart 4validators completed\033[0m"
echo "\033[43;31m
watch Logs :
                tail -f node-0/node.log
                tail -f node-1/node.log
                tail -f node-2/node.log
                tail -f node-3/node.log
\033[0m"