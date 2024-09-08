# Vizion

Vizion will provizion (🔥👌😂💯) a MacOS machine from scratch. The setup includes:
 - [Oh My Zsh](https://ohmyz.sh/)
 - [Neovim](https://neovim.io)
 - [Tmux](https://github.com/tmux/tmux)
 - [iTerm](https://www.iterm2.com/)

Vizion will assume your coding projects live in `~/Developer/code`, and the enterprise on `~/Developer/code/enterprise`.

## Installation

### 1. Generate a GitHub token

Go here:  https://github.com/settings/tokens

### 2. Sign into the App Store

**NOTE**: If you don't want to install Mac Store apps (you haven't signed in to the App Store), the script will fail. You'll need to go to the cloned GitHub repo `~/Developer/code/vizion`, delete the `mas` lines in `Brewfile`, and re-run `rake`

### 3. Install the XCode Developer Tools:

```
xcode-select --install
```

### 4. Install Homebrew

Go to https://brew.sh or run:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

And also **make sure you run the post install commands to add `brew` to the `$PATH`**

### 5. Install Vizion

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/christopher-francisco/vizion/master/install.sh)"
```

### 6. Save the SSH keys passphrases

Location: `~/.ssh`

Open the files and save the passphrases to your password manager

### 7. Add SSH Keys to GitHub

```
pbcopy < ~/.ssh/id_rsa.pub
```

### Install language servers

```
npm -g i typescript-language-server vscode-langservers-extracted eslint_d @fsouza/prettierd @tailwindcss/language-server
brew install lua-language-server
```

## Features
 - [x] Complete support for true colors and italics on iTerm, iTerm+Vim, iTerm+Tmux, iTerm+Tmux+Vim.
 - [x] Best mappings & plugins for Vim and Tmux

## Troubleshooting
>Hub returns *422 Invalid value for "base"* when running `hub pull-request`.

[As discussed in this issue](https://github.com/github/hub/issues/154#issuecomment-410277347), just set the base branch of the remote:

```bash
git remote set-head origin -a
```

> Tmux plugins won't load
[Install `gawk`](https://github.com/tmux-plugins/tpm/issues/146)
```bash
brew install gawk
```

> Neovim is all blue

Run iTerm, not the Terminal app

> zsh autosuggest-accept not working

Go to `System Preferences > Keyboard` and then go to `Keyboard Shortcuts > Input Sources` and then disable the shortcut with `ctrl + space` as it's conflicting
