#!/bin/bash

# generate_password 18
generate_password() {
  local password=$(openssl rand -base64 $1 | colrm $(expr $1 + 1) 2>&-)
  echo $password
}

confirm_overwrite_filename() {
  local filename=$1

  read -p "File $filename already exists. Overwrite (y/N): " overwrite

  if [[ $overwrite = "y" ]]; then
    rm $filename "$filename.pub"
    return 0
  else
    return 1
  fi
}

# create_key
# create_key enterprise
create_key() {
  if [[ -n $1 ]]; then
    local filename=~/.ssh/id_rsa_$1
  else
    local filename=~/.ssh/id_rsa
  fi

  # If filename exists, overwrite or quit
  if [[ -e $filename ]]; then
    confirm_overwrite_filename $filename
    if [[ $? -gt 0 ]]; then 
      return 1
    fi
  fi

  read -p "Email: " email
  local passphrase=$(generate_password 18)

  ssh-keygen -t rsa -b 4096 -C $email -f $filename -N $passphrase -q

  # TODO: issues/51
  # ssh-add -q -K $filename <<< '$passphrase'

  echo $passphrase;
}

main() {
  passphrases_output_file=~/.ssh/passphrases
  echo "# Save these passphrases to a safe place and delete this file" > $passphrases_output_file

  echo "Generating personal SSH key"
  passphrase_personal=$(create_key)

  if [[ 0 -eq $? ]]; then
    echo "Personal SSH key passphrase: $passphrase_personal" >> $passphrases_output_file
  else
    echo "Did not create Personal key"
  fi

  echo
  read -p "Generate enterprise SSH key? (Y/n): " generate_enterprise
  if [[ $generate_enterprise != "n" ]]; then
    read -p "Enterprise name: " enterprise_name
    passphrase_enterprise=$(create_key $enterprise_name)
    if [[ 0 -eq $? ]]; then
      echo "Enterprise SSH key passphrase: $passphrase_enterprise" >> $passphrases_output_file
    else
      echo "Did not create Enterprise key"
    fi
  fi

  echo
  echo "Passphrases saved to $passphrases_output_file"

  if [ ! -f ~/.ssh/config ]; then 
    echo "Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa" > ~/.ssh/config

    echo "Created ~/.ssh/config"
  fi
}

main
