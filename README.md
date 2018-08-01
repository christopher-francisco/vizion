# Provisioner

Provisioner will provision (🔥👌😂💯) a MacOS machine from scratch. This setup is what I like to call the holy trinity, since it includes:
 - [Oh My Zsh](https://ohmyz.sh/)
 - [Vim](https://www.vim.org/)
 - [Tmux](https://github.com/tmux/tmux)

Several other tools are also installed and configured such as:
 - [iTerm](https://www.iterm2.com/)

Provisioner will symlink dotfiles to the home directory, and will assume your coding projects live in `~/Developer/code`.

### Installation
Easy peasy lemon squeezy. Just run:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/chris-fa/dev-machine/master/install.sh)"
```

### Features
 - Complete support for true colors and italics on iTerm, iTerm+Vim, iTerm+Tmux, iTerm+Tmux+Vim.
 - Best mappings & plugins for Vim and Tmux

## Known bugs and TODO
### Rakefile
Need a task to upgrade everything. Install should not fail because upgrading

### Vim
 - [ ] Fix problem with vim airlines trying to load before installing the plugin
 - [ ] Move to vim-plug
 - [ ] Install YCM and tern_for_vim automatically after installing plugins (needs vim-plug)

### Neovim
 - [ ] Provision neovim

### Tmux
 - [ ] Install Tmux Plugin Manager (tpm) and run `prefix + I` automatically when running rake (currently need to start & attach to tmux, and then run `prefix + I`)

### SSH
 - [ ] Create a public/private key pair on install

### iTerm2
 - [ ] Automatically load color presets `directories/.iterm2/colors`
 - [ ] Automatically load `directories/.iterm2/com.googlecode.iterm2.plist` (#4)

### API Keys
 - [ ] Input and automatically export API keys and export them to `.zshrc.alias.local`

### Support for italics
 - [ ] Automatically do the setup (read `directories/.iterm2/files/README.md`)
