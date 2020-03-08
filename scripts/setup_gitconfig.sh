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

create_gitconfig() {
  local filename=$1

  if [[ -e $filename ]]; then
    promt_overwrite_filename $filename
    if [[ $? -gt 0 ]]; then
      return 1
    fi
  fi

  read -p "Name: " name
  read -p "Email: " email

  echo "[user]
  name = $name
  email = $email" > $filename
}

main() {
  local local_filename=~/.gitconfig.local
  echo "Creating local gitconfig"
  create_gitconfig $local_filename
  if [[ 0 -eq $? ]]; then
    echo "Created $local_filename"
  fi

  local enterprise_filename=~/.gitconfig.enterprise
  echo
  echo "Creating enterprise gitconfig"
  create_gitconfig $enterprise_filename
  if [[ 0 -eq $? ]]; then
    echo "Created $enterprise_filename"
  fi
}

main
