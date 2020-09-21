#!/bin/bash

# Directory containing agent_mongo
AGENT_MONGO_FOLDER=~/cosmos/source/tools/cosmos-mongodb


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


echo "Finished installing Agent MongoDB"


