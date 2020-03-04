#!/bin/bash
rm -f ~/.grip/settings.py  # Do not show an error if file doens't exist

cp -n ~/.grip/settings.py.example ~/.grip/settings.py

read -p "GitHub username: " username
read -s -p "GitHub token for grip: " token

sed -i '' "s|__USERNAME__|$username|g; s|__PASSWORD__|$token|g; " ~/.grip/settings.py
