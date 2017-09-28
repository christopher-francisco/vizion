SHELL=/bin/bash

install_xcode_tools:
	echo "First we will install xcode tools. You need to accept the prompt message"
	xcode-select --install

install_oh_my_zshell:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

install_brew:
	echo "Installing brew..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install_brew_items:
	echo "Installing brew formulaes. This may take a while..."
	brew install zsh
	brew install zsh-completions
	brew install ctags
	brew install editorconfig
	brew install neovim
	brew install node
	brew install ruby
	brew install tmux
	brew install tmux-completion
	brew install wget
	brew install zsh-autosuggestions
	brew install zsh-syntax-highlighting
	brew install ccat

install_brew_cask_items:
	echo "Installing casks. Your password may be asked..."
	brew cask install google-chrome
	brew cask install font-fira-code
	brew cask install docker
	brew cask install iterm2
	brew cask install licecap
	brew cask install macvim
	brew cask install mysqlworkbench
	brew cask install sequel-pro
	brew cask install slack
	brew cask install spectacle

install_npm_global_tools:
	npm install -g vtop

configure_git:
	echo -e "[user]\n\tname = Christopher Francisco\n\temail = christopher.f.almanza@gmail.com\n\n[core]\n\teditor = vim" > ~/.gitconfig
