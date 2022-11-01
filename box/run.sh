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

read -p "Enter Node name: " GEAR_NODENAME

printLine
echo -e "Node name: ${CYAN}$GEAR_NODENAME${NC}"
printLine
sleep 2

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

printCyan "Deleting Node previous installation..." && sleep 1
sudo systemctl stop gear-node
#sudo systemctl disable gear-node
sudo rm -rf /root/.local/share/gear-node
sudo rm /etc/systemd/system/gear-node.service
sudo rm /root/gear
sudo rm /root/gear-node
sudo rm /usr/local/bin/gear

printCyan "Cloning Gear repo..." && sleep 1
cd $HOME
git clone https://github.com/gear-tech/gear.git
cd gear

printCyan "Compiling Gear..." && sleep 1
cargo build -p gear-cli --release
chmod +x $HOME/gear
mv $HOME/gear $HOME/gear-node

#exec file dir
#/root/gear-node/target/release/gear
mv ~/gear-node/target/release/gear /usr/local/bin/

sudo tee /etc/systemd/system/gear-node.service > /dev/null <<EOF
[Unit]
Description=Gear Node
After=network.target
[Service]
User=root
ExecStart=$(which gear)gear --name=$GEAR_NODENAME --execution wasm --log runtime --listen-addr /ip4/0.0.0.0/tcp/9944 --telemetry-url 'ws://telemetry-backend-shard.gear-tech.io:32001/submit 0'
Restart=on-failure
RestartSec=3
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable gear-node
sudo systemctl restart gear-node

printLine

printCyan "Check Gear status..." && sleep 1
if [[ `service gear-node status | grep active` =~ "running" ]]; then
  echo -e "Your gear-node \e[32m. installed and works\e[39m!"
  echo -e "You can check node status by the command \e[7m. sudo systemctl status gear-node\e[0m"
  echo -e "You can check logs by the command \e[7m. sudo journalctl -n 100 -f -u gear-node\e[0m"
else
  echo -e "Your gear-node \e[31m. was not installed correctly\e[39m, please reinstall."
fi
