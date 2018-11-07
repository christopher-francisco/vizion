# Vizion

Vizion will provizion (🔥👌😂💯) a MacOS machine from scratch. This setup is what I like to call the holy trinity, since it includes:
 - [Oh My Zsh](https://ohmyz.sh/)
 - [Vim](https://www.vim.org/)
 - [Tmux](https://github.com/tmux/tmux)

Several other tools are also installed and configured such as:
 - [iTerm](https://www.iterm2.com/)

Provisioner will symlink dotfiles to the home directory, and will assume your coding projects live in `~/Developer/code`.

### Installation
Easy peasy lemon squeezy. Just run:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/chris-fran/vizion/master/install.sh)"
```

##### Temporal manual steps
1. `touch ~/.zshrc.aliases.local`
2. Read last section of `~/.zshrc.aliases and put tokens in there`
3. `cp -n ~/.grip/settings.py.example ~/.grip/settings.py; vim ~/.grip/settings.py`
4. Open that file and put your credentials


### Features
 - Complete support for true colors and italics on iTerm, iTerm+Vim, iTerm+Tmux, iTerm+Tmux+Vim.
 - Best mappings & plugins for Vim and Tmux

## Troubleshooting
>Hub returns *422 Invalid value for "base"* when running `hub pull-request`.

[As discussed in this issue](https://github.com/github/hub/issues/154#issuecomment-410277347), just set the base branch of the remote:

```
git remote set-head origin -a
```

## Known bugs and TODO
### Rakefile
Need a task to upgrade everything. Install should not fail because upgrading

### Vim
 - [ ] Fix problem with vim airlines trying to load before installing the plugin

### Neovim
 - [ ] Provision neovim

### Zsh
 - [ ] Auto setup .zshrc.aliases.local

### Grip
 - [ ] Automatically set up your username and token

### SSH
 - [ ] Create a public/private key pair on install

### iTerm2
 - [ ] Automatically load color presets `directories/.iterm2/colors`

### API Keys
 - [ ] Input and automatically export API keys and export them to `.zshrc.alias.local`
