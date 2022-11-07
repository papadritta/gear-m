#!/bin/bash
cd $HOME
sudo mkdir /root/backup
chmod +x /root/backup
sudo systemctl stop gear-node
cd /root/.local/share/gear-node/chains
sudo cp gear_staging_testnet_v3/network/secret_ed25519 /root/backup
cd $HOME
sudo systemctl start gear-node
