# gear
<img width="700" alt="Screen Shot 2022-11-01 at 20 54 41" src="https://user-images.githubusercontent.com/90826754/199250127-65b57da8-5005-43b4-8c79-633f770a146a.png">

## Recommended hardware requirements
- CPU: 2 CPU
- Memory: 8 GB RAM
- Disk: 250 GB SSD Storage
>Storage requirements will vary based on various factors (age of the chain, transaction rate, etc)

## Official documentation:

- website page [here](https://www.gear-tech.io)

- github repo [here](https://github.com/gear-tech/gear)

- docs & wiki [here](https://wiki.gear-tech.io/docs/)

## Set up your Gear full node (automatic):
>You can setup your Sui full node in minutes by using automated script below
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

## You need a server?
- Use the links with referal programm [VULTR](https://www.vultr.com) or [DO](https://www.digitalocean.com)

**NOTE!: use a referal link & you will get 100$ to your server provider account**

ALL DONE!!!
