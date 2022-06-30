#!/usr/bin/env bash

ln -s ./User ~/Library/Application\ Support/Code/User

extensions=$(cat ./extensions)
for extension in $extensions; do
  code --install-extension extension
done
