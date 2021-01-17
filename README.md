## Docker Composerized Headless Miner for Nine Chronicles

Nine Chronicles is an idle game created that runs on a blockchain based platform for multiplayer activities like PvP and Market activity.

It uses the in-game currency as a way to incentivize miners. 

This repository is an attempt to make it simpler for miners to run multiple containers, tweak options, and pull logs.

## Windows 10 x64 Systems: Version 1903 or higher, with Build 18362 or higher.

# Setup PC: WSL, Distro, Choco, & Docker
1. Run: setup_windows.cmd (as administrator) **Will be running again later**
2. Reboot PC
3. Run: setup_windows.cmd (as administrator) **again**

# Setup Distro & Docker Containers
1. Open CMD (as administrator)
2. RUN: wsl.exe
2. RUN: cd $HOME/9c-standalone-miner && sudo ./9c-standalone-miner.sh

# Monitor
1. Open Docker-Desktop on Windows
2. You can start/stop/restart/monitor your containers from here. As well as watch log output!


## Linux x64 Systems

# Setup

1. Install Docker.
2. Install Docker Compose.
3. Git clone this repository
4. Run: `sudo ./9c-standalone-miner.sh`

# Monitoring

- See the full log: `docker-compose logs --tail=100 -f`
- Watch for mined blocks: `docker-compose logs --tail=100 -f | grep -A 10 --color -i 'Mined a block'` 

# Check your NGC using the GraphQL Playground

_This works when using the normal docker-compose.yml which enables the graphql server_

- Visit: http://localhost:23061/ui/playground
- Enter the following Query and press the Play button:

```
query
{
  goldBalance(address: "YOUR_ADDRESS_HERE")
}
```
