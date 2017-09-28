# dev-machine

This project is a Makefile that will setup a development machine from scratch.

The development setup turns around the holy trinity:

- zsh
- vim
- tmux
- iterm2 (not part of the trinity, but welcomed)

### Installation

```bash
# TODO: change the URL to the actual github repo, this is just for piping reference
$ curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```

### Changing the shell

Use homebrew's zsh. *NOTE*: this ain't safe, it requires sudo. You better research before running it.

```bash
chsh -s /usr/local/bin/zsh
```
