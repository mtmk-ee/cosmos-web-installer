#!/bin/bash

# Root directory of COSMOS Web
COSMOS_WEB_FOLDER=~/cosmos/source/tools/cosmos-web

# Directory containing agent_mongo
AGENT_MONGO_FOLDER=~/cosmos/tools

# ======================= Dependencies =======================
echo "====================================================="
echo "Installing dependencies"

sudo apt-get update
sudo apt-get install nodejs npm
sudo apt-get install -y build-essential wget libz-dev gcc-7 g++-7 cmake git openssl libssl-dev libsasl2-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev




# Install MongoDB
echo "Installing MongoDB..."
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

sudo apt-get update
sudo apt-get install -y mongodb-org


# Install MongoDB C Driver
echo "Installing MongoDB C driver..."
echo "Downloading..."
wget https://github.com/mongodb/mongo-c-driver/releases/download/1.17.0/mongo-c-driver-1.17.0.tar.gz

tar xzf mongo-c-driver-1.17.0.tar.gz
cd mongo-c-driver-1.17.0
mkdir cmake-build
cd cmake-build

echo "Building..."
cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF ..
make

echo "Installing..."
sudo make install

echo "Cleaning up..."
rm mongo-c-driver-1.17.0.tar.gz
rm -rf mongo-c-driver-1.17.0


# Install MongoDB C++ Driver
echo "Installing MongoDB C++ Driver..."
echo "Downloading..."
wget https://github.com/mongodb/mongo-cxx-driver/releases/download/r3.6.0/mongo-cxx-driver-r3.6.0.tar.gz

tar xzf mongo-cxx-driver-r3.6.0.tar.gz
cd mongo-cxx-driver-r3.6.0
mkdir build
cd build

echo "Building..."
cmake -DCMAKE_BUILD_TYPE=Release -DBSONCXX_POLY_USE_BOOST=1 -DCMAKE_INSTALL_PREFIX=/usr/local ..
make -j4

echo "Installing..."
sudo make install

echo "Cleaning up..."
rm mongo-cxx-driver-r3.6.0.tar.gz
rm -rf mongo-cxx-driver-r3.6.0






# ======================= COSMOS Web =======================
echo "====================================================="

# Check if COSMOS Web is already installed
if [ -d "$COSMOS_WEB_FOLDER" ]; then
    echo "COSMOS Web is already installed."
    read -p "Remove existing installation? [y/n]: "
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Removing existing installation"
        rm -rf "$COSMOS_WEB_FOLDER"
        
        echo "Installing COSMOS Web..."
        echo "Downloading..."
        
        git clone https://github.com/spjy/cosmos-web.git ~/cosmos/source/tools/cosmos-web
        cd ~/cosmos/source/tools/cosmos-web

        echo "Installing..."
        npm install
        
        cp .env.defaults .env
    else
        echo "Skipped COSMOS Web installation"
    fi
else
    echo "Installing COSMOS Web..."
    echo "Downloading..."

    git clone https://github.com/spjy/cosmos-web.git ~/cosmos/source/tools/cosmos-web
    cd ~/cosmos/source/tools/cosmos-web

    echo "Installing..."
    npm install

    cp .env.defaults .env
fi






# ======================= Agent Mongo =======================

# Check if Agent MONGO is already installed
if [ -d "$AGENT_MONGO_FOLDER" ]; then
    echo "Agent Mongo is already installed."
    read -p "Remove existing installation? [y/n]: "
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Removing existing installation"
        rm -rf "$AGENT_MONGO_FOLDER"
        
        echo "Installing Agent Mongo..."
        echo "Downloading..."
        
        git clone https://github.com/spjy/cosmos-mongodb.git ~/cosmos/source/tools/cosmos-mongodb
        cd ~/cosmos/source/tools/cosmos-mongodb

        mkdir build
        cd build

        echo "Building..."

        cmake ../source
        make
    else
        echo "Skipped Agent Mongo installation"
    fi
else
    echo "Installing Agent Mongo..."
    echo "Downloading..."
    
    git clone https://github.com/spjy/cosmos-mongodb.git ~/cosmos/source/tools/cosmos-mongodb
    cd ~/cosmos/source/tools/cosmos-mongodb

    mkdir build
    cd build

    echo "Building..."

    cmake ../source
    make
fi


echo "Finished installation."


echo "Installing Agent Mongo..."
echo "Downloading..."



