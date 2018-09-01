#!/bin/bash


WHO=$(whoami)

# install npm v4
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
nvm install v4

# install ZeroMQ libraries
sudo apt-get -y install libzmq3-dev

# install bitcore (branched and patched from )
npm install anonymousbitcoin/bitcore-node-anon

# create bitcore node
./node_modules/bitcore-node-anon/bin/bitcore-node create anon-explorer
cd bitcoinprivate-explorer

# install patched insight api/ui
../node_modules/bitcore-node-anon/bin/bitcore-node install anonymousbitcoin/insight-api-anon anonymousbitcoin/insight-ui-anon

# create bitcore config file for bitcore and btcpd
# REPLACE "datadir" and "exec" with actual values of "/home/user"
cat << EOF > bitcore-node.json
{
  "network": "livenet",
  "port": 3001,
  "services": [
    "bitcoind",
    "insight-api-anon",
    "insight-ui-anon",
    "web"
  ],
  "servicesConfig": {
    "bitcoind": {
      "spawn": {
        "datadir": "/home/ubuntu/.anon",
        "exec": "/home/ubuntu/BitcoinPrivate/src/anond"
      }
    },
    "insight-ui-anon": {
      "apiPrefix": "api",
      "routePrefix": ""
    },
    "insight-api-anon": {
      "routePrefix": "api"
    }
  }
}
EOF



echo "Start the block explorer, open in your browser http://server_ip:3001"
echo "Run the following line as one line of commands to start the block explorer"
echo "nvm use v4; cd anon-explorer; ./node_modules/bitcore-node-anon/bin/bitcore-node start"
