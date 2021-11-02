#!/bin/bash
promt_overwrite_filename() {
  local filename=$1

  read -p "File $filename already exists. Overwrite (y/N): " overwrite

  if [[ $overwrite = "y" ]]; then
    return 0
  else
    return 1
  fi
}

main () {
  filename=~/.grip/settings.py

  if [[ -e $filename ]]; then
    promt_overwrite_filename $filename
    if [[ $? -gt 0 ]]; then
      return 1
    fi
  fi

  rm -f ~/.grip/settings.py  # Do not show an error if file doens't exist

  cp -n ~/.grip/settings.py.example ~/.grip/settings.py

  read -p "GitHub username (i.e: christopher-francisco): " username
  read -s -p "GitHub token for grip: " token

  sed -i '' "s|__USERNAME__|$username|g; s|__PASSWORD__|$token|g; " ~/.grip/settings.py
}

main
