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
echo "Updating repository..."
#git pull https://www.github.com/CryptoKasmDev/9c-standalone-miner.git 


# Update: Snapshot
./linux-scripts/refresh-snapshot.sh $NC_CONTAINERS

echo "Starting docker containers..."
# Start: Docker Containers
docker-compose -f docker/docker-compose.$NC_CONTAINERS.yml up -d


# Display status of all containers
echo "See the full log: `docker-compose logs --tail=100 -f` "
echo "Watch for mined blocks: `docker-compose logs --tail=100 -f | grep -A 10 --color -i 'Mined a block'`" 

# IF DisplayLog=True, auto run styilzed trail on containers


echo "--------------------------------------------"
echo "  Maintained by CryptoKasm"
echo "  Github - https://github.com/CryptoKasm"
echo "  Support - https://discord.gg/k6z2GS4yh2"
echo "--------------------------------------------\n"

read -p "  Press any key to exit..."