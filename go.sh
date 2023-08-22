#!/bin/bash

# View lines as they are run in logs
set -x

#
#move archipelago to archipelago folder out of temp
#
cp -r "/temp/Archipelago-"$1. "/archipelago/Archipelago-"$1

# move to archipelago folder
cd /archipelago

# download the env archipelago version
#curl -L $1$2".tar.gz" > "Archipelago-"$2".tar.gz"


# decompress
#tar -xf "Archipelago-"$2".tar.gz"

# copy base roms to the archipelago folder
cp -r /baseroms/. "/archipelago/Archipelago-"$1

# move to new folder
cd "Archipelago-"$1

# install setup requirements
#echo python3 -u setup.py -y

# start webhost (and probably install more requirements)
echo "\n" | python3 -u WebHost.py

echo "you shouldn't see this unless stopping manually"