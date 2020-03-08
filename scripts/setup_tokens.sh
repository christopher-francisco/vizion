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
  filename=~/.zshrc.tokens

  if [[ -e $filename ]]; then
    promt_overwrite_filename $filename
    if [[ $? -gt 0 ]]; then
      return 1
    fi
  fi

  read -s -p "Github cloud token (repo, gist permissions): " github_cloud_token
  echo

  read -p "Github enterprise username: " github_enterprise_username
  read -p "Github enterprise hostname: " github_enterprise_hostname
  read -s -p "Github enterprise token (repo, gist permissions): " github_enterprise_token
  echo

  echo "export HOMEBREW_GITHUB_API_TOKEN='$github_cloud_token'

# ----
# Used by ~/.netrc
# ----
export VIM_RHUBARB_CLOUD_TOKEN='$github_cloud_token'
export VIM_RHUBARB_ENTERPRISE_USERNAME='$github_enterprise_username'
export VIM_RHUBARB_ENTERPRISE_HOSTNAME='$github_enterprise_hostname'
export VIM_RHUBARB_ENTERPRISE_TOKEN='$github_enterprise_token'


useCloudGitHub() {
    export GITHUB_TOKEN='$github_cloud_token'
    export GITHUB_HOST=github.com
}
useEnterpriseGitHub() {
    export GITHUB_TOKEN='$github_enterprise_token'
    export GITHUB_HOST='$github_enterprise_hostname'
}" > $filename

echo "Created $filename"
}

main
