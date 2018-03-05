#!/bin/bash


WHO=$(whoami)

# install npm v4
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
nvm install v4

# install ZeroMQ libraries
sudo apt-get -y install libzmq3-dev

# install bitcore (branched and patched from )
npm install interbiznw-btcpcontrib/bitcore-node-btcp

# create bitcore node
./node_modules/bitcore-node-btcp/bin/bitcore-node create bitcoinprivate-explorer
cd bitcoinprivate-explorer

# install patched insight api/ui (branched and patched from https://github.com/BTCPrivate/insight-api-bitcoinprivate & https://github.com/BTCPrivate/insight-ui-bitcoinprivate)
../node_modules/bitcore-node-btcp/bin/bitcore-node install interbiznw-btcpcontrib/insight-api-btcp interbiznw-btcpcontrib/insight-ui-btcp

# create bitcore config file for bitcore and btcpd
# REPLACE "datadir" and "exec" with actual values of "/home/user"
cat << EOF > bitcore-node.json
{
  "network": "mainnet",
  "port": 3001,
  "services": [
    "bitcoind",
    "insight-api-bitcoinprivate",
    "insight-ui-bitcoinprivate",
    "web"
  ],
  "servicesConfig": {
    "bitcoind": {
      "spawn": {
        "datadir": "/home/ubuntu/.btcprivate",
        "exec": "/home/ubuntu/BitcoinPrivate/src/btcpd"
      }
    },
    "insight-ui-bitcoinprivate": {
      "apiPrefix": "api",
      "routePrefix": ""
    },
    "insight-api-bitcoinprivate": {
      "routePrefix": "api"
    }
  }
}
EOF



echo "Start the block explorer, open in your browser http://server_ip:3001"
echo "Run the following line as one line of commands to start the block explorer"
echo "nvm use v4; cd bitcoinprivate-explorer; ./node_modules/bitcore-node-btcp/bin/bitcore-node start"
