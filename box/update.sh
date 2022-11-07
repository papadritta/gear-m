#!/bin/bash

exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
	echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi

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

printCyan "Purging gear Node chain..." && sleep 1
/root/gear purge-chain -y

printCyan "Deleting Node previous installation..." && sleep 1
sudo rm -rf /root/.local/share/gear-node
sudo rm /root/gear
\sudo rm /usr/local/bin/gear
sudo rm /root/gear-node/*

printCyan "Cloning Gear repo..." && sleep 1
cd $HOME
git clone https://github.com/gear-tech/gear.git
cd gear

printCyan "Compiling Gear..." && sleep 1
cargo build -p gear-cli --release
cd $HOME
chmod +x $HOME/gear
mv $HOME/gear $HOME/gear-node
mv ~/gear-node/target/release/gear /usr/local/bin/

printCyan "Copy Key to testnet_v4..." && sleep 1
cd $HOME
sudo cp /root/backup/gear_staging_testnet_v3/network/secret_ed25519 /root/.local/share/gear-node/chains/gear_staging_testnet_v4/network/secret_ed25519

sudo systemctl restart gear-node

printLine

printCyan "Check Gear status..." && sleep 1
if [[ `service gear-node status | grep active` =~ "running" ]]; then
  echo -e "Your gear-node \e[32m. updated and works\e[39m!"
  echo -e "You can check node status by the command \e[7m. sudo systemctl status gear-node\e[0m"
  echo -e "You can check logs by the command \e[7m. sudo journalctl -n 100 -f -u gear-node\e[0m"
else
  echo -e "Your gear-node \e[31m. was not updated correctly\e[39m, please restart script again."
fi
