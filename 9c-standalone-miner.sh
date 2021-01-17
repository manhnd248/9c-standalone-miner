#!/bin/bash
source settings.conf

echo "--------------------------------------------"
echo "  Nine Chronicles - Standalone Miner"
echo "  Version 1.1.1-alpha"
echo "--------------------------------------------"

# Test: Root Privileges
if [ "$EUID" -ne 0 ]
  then echo "PLEASE RUN AS ROOT"
  exit
fi

# Check: Prerequisites
# docker
# docker-compose

# Update: Repository
#echo "Updating repository..."
#git pull --rebase https://www.github.com/CryptoKasmDev/9c-standalone-miner.git 

# Checking permissions
sudo chmod +x 9c-standalone-miner.sh
sudo chmod +x linux-scripts/refresh-snapshot.sh

# Setting docker-compose file
rm ./docker-compose.yml
cp docker/docker-compose.$NC_CONTAINERS.yml ./docker-compose.yml

# Check for .env file
if [ -f ".env" ]; then
    echo "      -Creditials Found" 
else
    echo "      -Credentials: Not Found"
    echo "      -Credentials: Creating File"
    echo
    echo " Please enter your Nine Chronicles Private Key"
    read -p "> " NCPRIVKEY
    echo "NINECHRONICLES_PRIVATE_KEY=$NCPRIVKEY" >> .env
    echo "Thank you! You can change this by editing the .env file"
    echo 
fi

# Update: Snapshot
./linux-scripts/refresh-snapshot.sh $NC_CONTAINERS

echo "Starting docker containers..."
# Start: Docker Containers
# docker-compose --compatibility up -d &
docker-compose up -d &

# Display status of all containers
#echo "See the full log: `docker-compose logs --tail=100 -f` "
#echo "Watch for mined blocks: `docker-compose logs --tail=100 -f | grep -A 10 --color -i 'Mined a block'`" 

# IF DisplayLog=True, auto run styilzed trail on containers


echo "--------------------------------------------"
echo "  Maintained by CryptoKasm"
echo "  Github - https://github.com/CryptoKasm"
echo "  Support - https://discord.gg/k6z2GS4yh2"
echo "--------------------------------------------"

read -p "  Press any key to exit..."