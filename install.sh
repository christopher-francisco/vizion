#!/bin/bash
if [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; then
  echo "XCode tools not found. Installing..."
  xcode-select --install
fi

echo "Installing dev-machine"
mkdir -p ~/Developer/code && cd "$_"
git clone https://github.com/chris-fa/dev-machine
cd dev-machine
rake