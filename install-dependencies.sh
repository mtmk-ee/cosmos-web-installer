#!/bin/bash


# ======================= Dependencies =======================
echo "====================================================="
echo "Installing dependencies"

sudo apt-get update
sudo apt install npm
sudo npm install -g npm@latest

sudo apt-get install nodejs
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

#echo "Cleaning up..."
#rm mongo-c-driver-1.17.0.tar.gz
#rm -rf mongo-c-driver-1.17.0

cd ../..

# Install MongoDB C++ Driver
echo "Installing MongoDB C++ Driver..."
echo "Downloading..."

#wget https://github.com/mongodb/mongo-cxx-driver/releases/download/r3.6.0/mongo-cxx-driver-r3.6.0.tar.gz

#tar xzf mongo-cxx-driver-r3.6.0.tar.gz
#cd mongo-cxx-driver-r3.6.0

git clone -b releases/stable https://github.com/mongodb/mongo-cxx-driver.git
cd mongo-cxx-driver


mkdir build
cd build

echo "Building..."
cmake -DCMAKE_BUILD_TYPE=Release -DBSONCXX_POLY_USE_BOOST=1 -DCMAKE_INSTALL_PREFIX=/usr/local ..
make -j4

echo "Installing..."
sudo make install

echo "Cleaning up..."
#rm -rf mongo-cxx-driver-r3.6.0



echo "Finished installing COSMOS Web dependencies"

