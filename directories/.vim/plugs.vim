call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/BufOnly.vim'                    " Delete all buffers but the current one
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'                          " We want to use Ultisnips with YCM. FIXME: I think I'm no longer using this?
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-exchange'                       " Exchange with `cx{motion}`
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
" Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'flowtype/vim-flow'                          " Flow type. TODO: is this already in polyglot???
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --java-completer' } " We want completion
Plug 'easymotion/vim-easymotion'                  " Move through file using letters instead of numbers
Plug 'AndrewRadev/splitjoin.vim'                  " Split and join with gS and gJ
Plug 'rakr/vim-one'                               " colorscheme one
Plug 'morhetz/gruvbox'                            " colorscheme gruvbox
Plug 'tmux-plugins/vim-tmux-focus-events'         " Fix FocusGained event when running inside tmux
Plug 'tmux-plugins/vim-tmux'                      " Convenient commands for when editing .tmux.conf
Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }
Plug 'qpkorr/vim-bufkill'                         " We want to delete a buffer without closing the split
Plug 'peitalin/vim-jsx-typescript'                " Use this until polyglot supports it
Plug 'vim-scripts/turbo.vim'                      " Turbo C colors
Plug 'sjl/gundo.vim'
Plug 'ryanoasis/vim-devicons'                     " We want glyphs
Plug 'dense-analysis/ale'                         " Might replace syntastic
Plug 'Rigellute/rigel'                            " Colorscheme rigel
Plug 'majutsushi/tagbar'
Plug 'jez/vim-github-hub'                         " Filetype for github/hub
Plug 'bfontaine/Brewfile.vim'
Plug 'christoomey/vim-tmux-navigator'             " Navigate between panes/splits
Plug 'wellle/context.vim'                         " Hover the context on top of the file
Plug 'camspiers/lens.vim'                         " Auto-resize of splits
Plug 'camspiers/animate.vim'

call plug#end()
