#!/bin/bash

# This file is primarily for debugging purposes and may be deleted at any time. If you need to rely on it, make your own copy, or create a pr to remove this line.

UTILS="/usr/local/steemd-testnet/bin"

chown -R steemd:steemd $HOME

# clean out data dir since it may be semi-persistent block storage on the ec2 with stale data
rm -rf $HOME/*

cd $HOME

cp /etc/nginx/steemd.nginx.conf /etc/nginx/nginx.conf

cd $HOME

# setup tinman
git clone --branch master https://github.com/steemit/tinman
virtualenv -p $(which python3) ~/ve/tinman
source ~/ve/tinman/bin/activate
cd tinman
pip install pipenv && pipenv install
pip install .

cd $HOME

jq ".shared_secret=\"$SHARED_SECRET\"" $HOME/tinman/server.conf.example > $HOME/server.conf

chown -R steemd:steemd $HOME/*

echo server-testnet: starting server on port 5000
tinman server \
  --get-dev-key $UTILS/get_dev_key \
  --signer $UTILS/sign_transaction \
  --timeout 600 \
  --chain-id $CHAIN_ID

