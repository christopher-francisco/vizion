#!/usr/bin/env bash

dir=$(pwd)
ln -s $dir/vscode/User ~/Library/Application\ Support/Code/User

extensions=$(cat ./vscode/extensions)
for extension in $extensions; do
  code --install-extension $extension
done
