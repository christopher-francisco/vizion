#!/bin/bash
extension=$1

read -p "Name: " name
read -p "Email: " email


echo "[user]
  name = $name
  email = $email" > ~/.gitconfig.$extension
