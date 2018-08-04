call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips'                           " TODO: Do we need supertab for this?
Plug 'honza/vim-snippets'                         " TODO: Does this work with ultisnip??
Plug 'arnaud-lb/vim-php-namespace'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'ervandew/supertab'                          " Let's autocomplete with tabs. Delete after YCM works. TODO: Do I have to delete this? i remember it not working if deleted??
Plug 'rking/ag.vim'                               " TODO: completely replace with Ack.vim
Plug 'Chun-Yang/vim-action-ag'                    " Let us search for text objects in normal and visual modes
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'skwp/greplace.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'                       " Read the docs, this is actually very good
Plug 'tpope/vim-abolish'                          " Provide useful case-insensistive string replacing operations
Plug 'tpope/vim-eunuch'                           " Sugar for UNIX commands
Plug 'tpope/vim-jdaddy'                           " JSON manipulation
Plug 'tpope/vim-capslock'                         " Software CAPS LOCK: `<C-G>c` in insert mode, `gC` in normal mode
Plug 'tpope/vim-rhubarb'                          " Browser enterprise GitHub
Plug 'godlygeek/tabular'                          " Aligning
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'flowtype/vim-flow'                          " Flow type. TODO: is this already in polyglot???
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --java-completer' } " We want completion
Plug 'easymotion/vim-easymotion'                  " Move through file using letters instead of numbers
Plug 'AndrewRadev/splitjoin.vim'                  " Split and join with gS and gJ
Plug 'mileszs/ack.vim'                            " Use Ack
Plug 'rakr/vim-one'                               " colorscheme one
Plug 'morhetz/gruvbox'                            " colorscheme gruvbox
Plug 'tmux-plugins/vim-tmux-focus-events'         " Fix FocusGained event when running inside tmux
Plug 'tmux-plugins/vim-tmux'                      " Convenient commands for when editing .tmux.conf

call plug#end()
