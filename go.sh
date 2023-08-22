#!/bin/bash

# View lines as they are run in logs
set -x

# move to archipelago folder
cd /archipelago

# download the env archipelago version
curl -l $1$2".tar.gz"

ls

# decompress
tar -xf "Archipelago-"$2".tar.gz"

# copy base roms to the archipelago folder
cp -a /baseroms/. "/Archipelago-"$2

# move to new folder
cd "Archipelago-"$2

# install setup requirements
echo "\n" | python3 -u setup.py

# start webhost (and probably install more requirements)
echo "\n" | python3 -u WebHost.py

echo "you shouldn't see this unless stopping manually"