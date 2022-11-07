# gear
<img width="700" alt="Screen Shot 2022-11-01 at 20 54 41" src="https://user-images.githubusercontent.com/90826754/199250127-65b57da8-5005-43b4-8c79-633f770a146a.png">

## Recommended hardware requirements
- CPU: 2 CPU
- Memory: 8 GB RAM
- Disk: 150 GB SSD Storage
>Storage requirements will vary based on various factors (age of the chain, transaction rate, etc)

## Official documentation:

- website page [here](https://www.gear-tech.io)

- github repo [here](https://github.com/gear-tech/gear)

- docs & wiki [here](https://wiki.gear-tech.io/docs/)

## Set up your Gear full node (automatic):
>You can setup your Sui full node in minutes by using automated script below
>Tested on Ubuntu 20.04.5 LTS & Ubuntu 22.04.1 LTS
```
wget -O run.sh https://raw.githubusercontent.com/papadritta/gear-m/main/box/run.sh && chmod +x run.sh && ./run.sh
```
## Check status of your node:
```
sudo systemctl status gear-node
```

## Check logs of your node:
```
sudo journalctl -n 100 -f -u gear-node
```

## Find your Node in telemetry [here](https://telemetry.gear-tech.io/#/0x6f022bd353c56b3e441507e1173601fd9dc0fb7547e6a95bbaf9b21f311bcab6) 

## Make a backup your Key
>your key will store in backup folder under path /root/backup/secret_ed25519
```
cd $HOME
sudo mkdir /root/backup
chmod +x /root/backup
sudo systemctl stop gear-node
cd /root/.local/share/gear-node/chains
sudo cp gear_staging_testnet_v3/network/secret_ed25519 /root/backup
cd $HOME
sudo systemctl start gear-node
```
## You need a server?
- Use the links with referal programm <a href="https://www.vultr.com/?ref=8997131"><img src="https://www.vultr.com/media/logo_ondark.png?_gl=1*rz7yd*_ga*MTE0OTQ2MjAwOS4xNjY3MzEwNjM0*_ga_K6536FHN4D*MTY2NzMxNTYyOS4yLjEuMTY2NzMxNjEwNS4wLjAuMA.." alt="VULTR Referral Badge" /></a>            <a href="https://www.digitalocean.com/?refcode=87b8b298c106&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge"><img src="https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg" alt="DigitalOcean Referral Badge" /></a>

**NOTE!: use a referal link & you will get 100$ to your server provider account**

ALL DONE!!!
