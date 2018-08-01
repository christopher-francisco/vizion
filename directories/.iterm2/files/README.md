# True color & italics config for tmux and iterm 
See https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be

## Installation
1. Install by running these
```
tic -x xterm-256color-italic.terminfo
tic -x tmux-256color.terminfo
```

2. Add `export TERM=xterm-256color-italic` to your shell profile.

### iTerm
1. On iTerm go to Preferences > Profiles > [your profile]
2. Make sure Text > Italics allowed is checked
3. Terminal > Report Terminal Type to `xterm-256color-italic` (this is supposed to set $TERM but it isn't. Most likely something else is overriding it, so we just rely on shell profile)

### Tmux
Add to .tmux.config
```
set -g default-terminal 'tmux-256color'
set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'
```
_Note: for this to work, $TERM must be already set properly_

### Vim
Add to .vimrc
```
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
```
