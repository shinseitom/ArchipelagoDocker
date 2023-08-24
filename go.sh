#!/bin/bash

# View lines as they are run in logs
set -x

# move archipelago to archipelago folder out of temp
cp -r "/temp/Archipelago-"$1 "/archipelago/Archipelago-"$1

# move to archipelago folder
cd /archipelago

# copy base roms to the archipelago folder
cp -r /baseroms/. "/archipelago/Archipelago-"$1

# move to new folder
cd "Archipelago-"$1

# start webhost (send enter in case it tries to install more stuff)
echo "\n" | python3 -u WebHost.py

echo "you shouldn't see this unless something is wrong"