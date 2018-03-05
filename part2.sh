#!/bin/bash

# install bitcore (branched and patched from )
npm install interbiznw-btcpcontrib/bitcore-node-btcp

# create bitcore node
./node_modules/bitcore-node-btcp/bin/bitcore-node create bitcoinprivate-explorer
cd bitcoinprivate-explorer

# install patched insight api/ui (branched and patched from https://github.com/BTCPrivate/insight-api-bitcoinprivate & https://github.com/BTCPrivate/insight-ui-bitcoinprivate)
../node_modules/bitcore-node-btcp/bin/bitcore-node install interbiznw-btcpcontrib/insight-api-btcp interbiznw-btcpcontrib/insight-ui-btcp
