# Pentacle Setup Script

This repository contains scripts for setting up and managing the Pentacle development network.

## set_node.sh

The `set_node.sh` script is used for downloading and installing go-quorum, as well as setting up a network with 4 validators.

## start_node.sh

The `start_node.sh` script is used to start the 4 validators in the network. Please note that it uses ports 22000 to 22003, 33000 to 33003, and 30300 to 30303.

## clear.sh

The `clear.sh` script is used for a complete reset. It shuts down the running validators and deletes all files.

Please refer to the individual script files for more details on their usage.

## Usage

1. Grant execution permissions to script files before running ```chmod +x set_node.sh start_node.sh clear.sh``` 

2. Run the `set_node.sh` script to download and install go-quorum and set up the network.

3. Run the `start_node.sh` script to start the 4 validators in the network.

4. If you need to reset everything, you can run the `clear.sh` script to shut down the validators and delete all files.

