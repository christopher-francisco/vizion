#!/bin/bash
read -p "Github Enterprise URL: " enterprise_url

echo "let g:github_enterprise_urls = ['$enterprise_url']" >> ~/.vimrc.local
