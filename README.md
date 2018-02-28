# dev-machine

This project is a Rakefile that will setup a development machine from scratch.

The development setup turns around the holy trinity:

- zsh
- vim
- tmux
- iterm2 (not part of the trinity, but welcomed)

It will also link dotfiles.

### Installation
Install this repo running
```
// insert here a SH command to create directory on ~/Developer/code/ruby/dev-machine, and clone this repo.
```

And then run
```
rake
```

## TODO
### .hushlogin
Create and link a `.hushlogin` file to the home directory to remove the annoying "last login" message. See: https://ashokgelal.com/2017/01/04/til-iterm-hush-last-login/

### vim
Figure out what to do with the bin/vim (macvim's vim) vs actual vim possible from homebrew?
fix problem with vim airlines trying to load before installing the plugin
install ycm and tern_for_vim after. Consider vim-plug

### tmux

Remember to install Tmux Plugin Manager (tpm) and run `prefix + I` to install the plugins listed in `.tmux.conf`. This doesn't exist yet in this repository.

Check TODO line on `dotfiles/.tmux.conf`. There's a thing for itallics and better mappings


### ssh
option to create a public/private key pair

### iterm2
configure settings
automatically load color presets from .iterm2

Configure the terminfo file in `directories/.iterm2/xterm-256color-itallic.terminfo` reading the comments on that file

Add to rakefile a way to load `directories/.iterm2/com.googlecode.iterm2.plist` with the following commands:

```bash
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/Developer/code/ruby/dev-machine/directories/.iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
```

### tokens
reminder to add a githu homebrew token and similar
