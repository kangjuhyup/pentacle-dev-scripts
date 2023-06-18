#!/bin/sh

os="`uname -s`"




chainId=55555555
pentacle='pentacle-quorum'

echo "\033[43;31mInstall go-quorum\033[0m"
git clone https://github.com/ConsenSys/quorum.git
echo "\033[43;31mPetacle using go-quorum v23.4.0\033[0m"
cd quorum && git checkout tags/v23.4.0
echo "\033[43;31mBuild go-quorum...\033[0m"
path=${pwd}
make all 
echo "\033[43;31mSet go-quorum path...\033[0m"
if [[ "$os" = "Drawin"* ]]; then
    echo export PATH="$PATH:${path}/build/bin" >> ~/.zshrc
    echo "\033[43;31mReload config...\033[0m"
    source ~/.zshrc
elif [[ "$os" = "Linux"* ]]; then
    echo export PATH="$PATH:${path}/build/bin" >> ~/.bashrc
    echo "\033[43;31mReload config...\033[0m"
    source ~/.bashrc

echo "\033[43;31mGenerate Private QBFT Node 4validators...\033[0m"
mkdir -p node-0/data/keystore node-1/data/keystore node-2/data/keystore node-3/data/keystore

echo "\033[43;31mMake genesis.json...\033[0m"
npx quorum-genesis-tool --consensus qbft --chainID $chainId --blockperiod 1 --requestTimeout 10 --epochLength 30000 --difficulty 1 --gasLimit '0xFFFFFF' --coinbase '0x0000000000000000000000000000000000000000' --validators 4 --members 0 --bootnodes 0 --outputPath $pentacle -y
mv $pentacle/*/* $pentacle
rm $pentacle/goQuorum/static-nodes.json
echo '[
    "enode://1647ade9de728630faff2a69d81b2071eac873d776bfdf012b1b9e7e9ae1ea56328e79e34b24b496722412f4348b9aecaf2fd203fa56772a1a5dcdaa4a550147@localhost:30300?discport=0&raftport=53000",
    "enode://0e6f7fff39188535b6084fa57fe0277d022a4beb988924bbb58087a43dd24f5feb78ca9d1cd880e26dd5162b8d331eeffee777386a4ab181528b3817fa39652c@localhost:30301?discport=0&raftport=53001",
    "enode://d40a766cb6fe75f052fe21f61bc84ca3851abb6f999d73f97dd76e14fc2dea175d4cf554ccbcc2c7c639a0901932775b523554cb73facdfab08def975208f8e6@localhost:30302?discport=0&raftport=53002",
    "enode://80a98f66d243c6604cda0e1c722eed3d9e080591c81710eec70794e0909e58661f4863e29a7a63bf7fb9387afc8609df37bacbf3d5c523d97bf598c3470840f5@localhost:30303?discport=0&raftport=53003"
    ]' >> ./$pentacle/goQuorum/static-nodes.json
cp $pentacle/goQuorum/static-nodes.json $pentacle/goQuorum/permissioned-nodes.json

echo "\033[43;31mmove genesis.json to node data...\033[0m"
cp $pentacle/goQuorum/static-nodes.json $pentacle/goQuorum/genesis.json node-0/data/
cp $pentacle/goQuorum/static-nodes.json $pentacle/goQuorum/genesis.json node-1/data/
cp $pentacle/goQuorum/static-nodes.json $pentacle/goQuorum/genesis.json node-2/data/
cp $pentacle/goQuorum/static-nodes.json $pentacle/goQuorum/genesis.json node-3/data/

echo "\033[43;31mmove nodeKey to node data...\033[0m"
cp $pentacle/validator0/nodekey* $pentacle/validator0/address node-0/data
cp $pentacle/validator1/nodekey* $pentacle/validator1/address node-1/data
cp $pentacle/validator2/nodekey* $pentacle/validator2/address node-2/data
cp $pentacle/validator3/nodekey* $pentacle/validator3/address node-3/data

echo "\033[43;31mmove account to node keystore...\033[0m"
cp $pentacle/validator0/account* $pentacle/validator0/address node-0/data/keystore
cp $pentacle/validator1/account* $pentacle/validator1/address node-1/data/keystore
cp $pentacle/validator2/account* $pentacle/validator2/address node-2/data/keystore
cp $pentacle/validator3/account* $pentacle/validator3/address node-3/data/keystore

echo "\033[43;31mgeth init...\033[0m"
geth --datadir node-0/data init node-0/data/genesis.json
geth --datadir node-1/data init node-1/data/genesis.json
geth --datadir node-2/data init node-2/data/genesis.json
geth --datadir node-3/data init node-3/data/genesis.json
