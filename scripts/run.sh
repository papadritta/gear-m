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

sleep 1 && curl -s https://raw.githubusercontent.com/papadritta/scripts/main/logo.sh | bash && sleep 2

echo -e "\e[1m\e[32m1. Updating packages... \e[0m" && sleep 1
sudo apt update && sudo apt upgrade -y

echo -e '\n\e[42m. Installing dependencies... \e[0m\n' && sleep 1
apt-get update && apt-get install -y git clang llvm ca-certificates curl build-essential binaryen libssl-dev pkg-config libclang-dev cmake jq

echo -e '\n\e[42m. Installing Rust... \e[0m\n' && sleep 1
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env

echo -e '\n\e[42m. Installing WASM toolchain... \e[0m\n' && sleep 1
rustup toolchain add nightly
rustup target add wasm32-unknown-unknown --toolchain nightly


#rm -rf $HOME/gear-node
# mkdir -p $HOME/gear-node
# chmod +x $HOME/gear-node

sudo systemctl stop gear-node
sudo systemctl disable gear-node
sudo rm -rf /root/.local/share/gear-node
sudo rm /etc/systemd/system/gear-node.service
sudo rm /root/gear


cd $HOME
git clone https://github.com/gear-tech/gear.git
cd gear
cargo build -p gear-cli --release
./target/release/gear
# cd target/release
chmod +x $HOME/gear
# mv $HOME/gear $HOME/gear-node


sudo tee /etc/systemd/system/gear-node.service > /dev/null <<EOF
[Unit]
Description=Gear Node
After=network.target
[Service]
User=root
ExecStart=$(which gear) start --name=$GEAR_NODENAME --execution wasm --log runtime --listen-addr /ip4/0.0.0.0/tcp/9944 --telemetry-url 'ws://telemetry-backend-shard.gear-tech.io:32001/submit 0'
Restart=on-failure
RestartSec=3
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable gear-node
sudo systemctl restart gear-node

echo "==================================================="
echo -e '\n\e[42mCheck Sui status\e[0m\n' && sleep 1
if [[ `service gear-node status | grep active` =~ "running" ]]; then
  echo -e "Your gear-node \e[32m. installed and works\e[39m!"
  echo -e "You can check node status by the command \e[7m. sudo systemctl status gear-node\e[0m"
  echo -e "Press \e[7mQ\e[0m for exit from status menu"
else
  echo -e "Your gear-node \e[31m. was not installed correctly\e[39m, please reinstall."
fi

