#!/bin/bash

set -e

sudo apt install git -y

echo "Downloading rust...."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source $HOME/.cargo/env

echo "Cloning AngryOxide"

git clone https://github.com/Ragnt/AngryOxide.git
cd AngryOxide

echo "Building Project...."
make

echo "Installing AngryOxide"
sudo make install

echo "Installation complete"