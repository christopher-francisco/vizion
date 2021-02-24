#!/bin/bash
# Usage
#   ./generate-gpg-key.sh

# generate_password 18
generate_password() {
  local password=$(openssl rand -base64 $1 | colrm $(expr $1 + 1) 2>&-)
  echo $password
}

generate_key() {
  read -p "Email: " email
  local passphrase=$(generate_password 18)

  gpg \
    --batch \
    --pinentry-mode loopback \
    --passphrase $passphrase \
    --yes \
    --quick-generate-key $email rsa4096/cert,sign+rsa4096/encr default never 

  echo $passphrase
}

main() {
  passphrases_output_file=~/.ssh/passphrases
  echo "# Save these passphrases to a safe place and delete this file" > $passphrases_output_file

  echo "Generating personal SSH key"
  passphrase=$(generate_key)

  if [[ 0 -eq $? ]]; then
    echo "GPG key passphrase: $passphrase" >> $passphrases_output_file
  else
    echo "Did not create GPG key"
  fi
}

main
