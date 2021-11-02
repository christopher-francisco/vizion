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

main() {
  filename=~/.vimrc.local

  if [[ -e $filename ]]; then
    promt_overwrite_filename $filename
    if [[ $? -gt 0 ]]; then
      return 1
    fi
  fi

  read -p "Github Enterprise URL: " enterprise_url

  echo "let g:github_enterprise_urls = ['$enterprise_url']" >> ~/.vimrc.local
}

main
