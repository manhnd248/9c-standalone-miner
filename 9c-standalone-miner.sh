#!/bin/bash
source settings.conf

echo "--------------------------------------------"
echo "  Nine Chronicles - Standalone Miner"
echo "  Version 1.1.1-alpha"
echo "--------------------------------------------\n"

# Test: Root Privileges
if [ "$EUID" -ne 0 ]
  then echo "PLEASE RUN AS ROOT"
  exit
fi

# Check: Prerequisites
# docker
# docker-compose

# Update: Repository
# git sync https://www.github.com/CryptoKasmDev/9c-standalone-miner.git 


# Update: Snapshot
#sh ./linux-scripts/refresh-snapshot.sh $NC_CONTAINERS

echo $NC_SECRET_KEY
echo $NC_CONTAINERS
echo $NC_AUTORESTART
echo $NC_AUTORESTARTTIMER
echo $NC_LOGGING
echo $NC_DISPLAYLOG

# Start: Docker Containers



# Display status of all containers


# IF DisplayLog=True, auto run styilzed trail on containers


echo "--------------------------------------------"
echo "  Maintained by CryptoKasm"
echo "  Github - https://github.com/CryptoKasm"
echo "  Support - https://discord.gg/k6z2GS4yh2"
echo "--------------------------------------------\n"

read -p "Press any key to exit..."