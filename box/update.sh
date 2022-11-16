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

printCyan "Installing dependencies..." && sleep 1
apt-get update && apt-get install -y git clang llvm ca-certificates curl build-essential binaryen protobuf-compiler libssl-dev pkg-config libclang-dev cmake jq

printCyan "Installing Rust..." && sleep 1
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env

printCyan "Installing WASM toolchain..." && sleep 1
rustup toolchain add nightly
rustup target add wasm32-unknown-unknown --toolchain nightly

printCyan "Copy Key to backup..." && sleep 1
cd $HOME
sudo mkdir /root/backup
chmod +x /root/backup
sudo systemctl stop gear-node
cd /root/.local/share/gear-node/chains
sudo cp gear_staging_testnet_v3/network/secret_ed25519 /root/backup
cd $HOME

printCyan "Deleting Node previous installation..." && sleep 1
sudo rm -rf /root/.local/share/gear-node
#sudo rm /root/gear
sudo rm /usr/local/bin/gear
sudo rm -rf /root/gear-node

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
sudo systemctl restart gear-node

printCyan "Restore Key from backup..." && sleep 1
cd $HOME
sudo systemctl stop gear-node
sudo cp /root/backup/secret_ed25519 /root/.local/share/gear-node/chains/gear_staging_testnet_v4/network/secret_ed25519

sudo systemctl restart gear-node

printLine

printCyan "Check Gear status..." && sleep 1
if [[ `service gear-node status | grep active` =~ "running" ]]; then
  echo -e "Your gear-node \e[32m. has been updated and works\e[39m!"
  echo -e "You can check node status by the command \e[7m. sudo systemctl status gear-node\e[0m"
  echo -e "You can check logs by the command \e[7m. sudo journalctl -n 100 -f -u gear-node\e[0m"
else
  echo -e "Your gear-node \e[31m. was not updated correctly\e[39m, please install Gear node script"
fi
