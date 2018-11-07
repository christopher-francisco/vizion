#!/bin/bash
if [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; then
  echo "XCode tools not found. Installing..."
  xcode-select --install
fi

echo "Installing vizion"
mkdir -p ~/Developer/code && cd "$_"
git clone https://github.com/chris-fran/vizion
cd vizion
rake
