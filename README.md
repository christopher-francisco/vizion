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

### 2. Install the XCode Developer Tools:

```
xcode-select --install
```

### 3. Install Vizion

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/christopher-francisco/vizion/master/install.sh)"
```

### 4. Save the SSH keys passphrases

Location: `~/.ssh/passphrases`

### 5. Add SSH Keys to GitHub

```
pbcopy < ~/.ssh/id_rsa.pub
```

### 6. Add key to agent

```
ssh-add -K ~/.ssh/id_rsa
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
