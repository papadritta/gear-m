# Gear (Testnet V4)
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

## 1. Install Gear full node (automatic script):
>Build from source

>You can setup your Gear full node in minutes by using automated script below

>Tested on Ubuntu 20.04.5 LTS & Ubuntu 22.04.1 LTS
```
wget -O run.sh https://raw.githubusercontent.com/papadritta/gear-m/main/box/run.sh && chmod +x run.sh && ./run.sh
```
## 2. Update Gear full node (automatic script):
>Build from source
>Script work correctly if you used source script run.sh for installation
```
wget -O update.sh https://raw.githubusercontent.com/papadritta/gear-m/main/box/update.sh  && chmod +x update.sh && ./update.sh
```
## 3. Additional commands:

- Check status of your node:
```
sudo systemctl status gear-node
```

- Check logs of your node:
```
sudo journalctl -n 100 -f -u gear-node
```

- Find your Node in telemetry [here](https://telemetry.gear-tech.io/#list/0xd144f24baf0b991be22ea8dc7dd4540d9d1e971e6bf17b1770b9fc9c88272484) 

- Make a backup your Key (automatic script):
>your key will store in backup folder under path /root/backup/secret_ed25519
```
wget -O backup.sh https://raw.githubusercontent.com/papadritta/gear-m/main/box/backup.sh && chmod +x backup.sh && ./backup.sh
```

## Do you need a server?
- Use the links with referal programm <a href="https://www.vultr.com/?ref=8997131"><img width="200" src="https://user-images.githubusercontent.com/90826754/200262610-b6251a9b-36a9-44f7-be30-fa691e7238de.png" a>
            <a href="https://www.digitalocean.com/?refcode=87b8b298c106&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge"><img src="https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg" alt="DigitalOcean Referral Badge" /></a>

**NOTE!: use a referal link & you will get 100$ to your server provider account**

ALL DONE!!!
