#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/papadritta/scripts/main/main.sh)

printLogo

printCyan "Updating packages..." && sleep 1
sudo apt update && sudo apt upgrade -y

printCyan "Copy Key to backup..." && sleep 1
cd $HOME
sudo mkdir /root/backup
chmod +x /root/backup
sudo systemctl stop gear-node
cd /root/.local/share/gear-node/chains
sudo cp gear_staging_testnet_v3/network/secret_ed25519 /root/backup
cd $HOME
sudo systemctl restart gear-node

printLine

printCyan "your key stored /root/backup/secret_ed25519" && sleep 1

