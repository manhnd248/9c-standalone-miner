#!/bin/bash

echo "--------------------------------------------"
echo "  Nine Chronicles - Refreshing Snapshot"
echo "--------------------------------------------"

# Build: Clean Docker Environment (Delete/Start/Stop Containers)
echo " -> Task-Start: Cleaning docker environment..."
docker-compose down -v      # Stops & deletes environment **snapshot**
docker-compose --compatibility up -d        # Restarts to recreate clean environment
docker-compose stop         # Stops cleaned environment for snapshot update
echo " -> Task-End: Cleaning docker environment..."

# Download Latest Nine Chronicles Snapshot
echo " -> Task-Start: Downloading snapshot data..."
NC_SNAPSHOT=latest-snapshot/9c-main-snapshot.zip
if [ -f "$NC_SNAPSHOT" ]; then
    echo "      -Snapshop > Found"
    echo "      -Deleting old snapshot"
    rm -rf latest-snapshot/*
else
    echo "      -Snapshop > Not Found"
fi

echo "      -Downloading latest snapshot"
cd latest-snapshot
curl -O https://download.nine-chronicles.com/latest/9c-main-snapshot.zip
echo "      -Unzipping snapshot"
unzip 9c-main-snapshot.zip
echo "      -Remmoving tmp files"
rm 9c-main-snapshot.zip
echo " -> Task-End: Downloading snapshot data..."


# Prepare Snapshot Data for Docker Containers
echo " -> Task-Start: Preparing snapshot data for containers..."

# It would be much better to look for the proper volumes and grab the path with inspect
echo "      -Copying snapshot data to volumes"
NC_VOLUMES=$1

case $NC_VOLUMES in
  1)
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner1-volume/_data/
    ;;

  2)
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner1-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner2-volume/_data/
    ;;

  3)
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner1-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner2-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner3-volume/_data/
    ;;

  4)
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner1-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner2-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner3-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner4-volume/_data/
    ;;
  5)
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner1-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner2-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner3-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner4-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner5-volume/_data/
    ;;
  6)
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner1-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner2-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner3-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner4-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner5-volume/_data/
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner6-volume/_data/
    ;;
  *)
    sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner1-volume/_data/
    ;;
esac

echo " -> Task-End: Preparing snapshot data for containers..."

echo "--------------------------------------------"
echo "  Nine Chronicles - Snapshot Refreshed"
echo "--------------------------------------------"