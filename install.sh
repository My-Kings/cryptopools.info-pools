#!/bin/sh

echo "Installing required packages"

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y install build-essential golang-1.10-go unzip redis-server nginx screen
sudo ln -s /usr/lib/go-1.10/bin/go /usr/local/bin/go
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Checking go & node version"

go version
node -v

echo "Installing REOSC"

wget https://github.com/REOSC/mn/releases/download/2.1.4/reosc-node
chmod +x reosc-node
sudo cp reosc-node /usr/local/bin/reosc

echo "Installing REOSC Pool Software"

git clone https://github.com/My-Kings/kings-reosc-pool
cd kings-reosc-pool
make all
sudo cp build/bin/kings-reosc-pool /usr/local/bin/kings-reosc-pool

echo "Done installing REOSC-Node & REOSC Pool Software!, Please configure your pool with the following instructions on Google"
