#!/bin/bash

# Root directory of COSMOS Web
COSMOS_WEB_FOLDER=~/cosmos/source/tools/cosmos-web



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

echo "Finished installing COSMOS Web."


