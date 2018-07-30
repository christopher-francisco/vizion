filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'                       " let Vundle manage Vundle, required
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'                          " Let's autocomplete with tabs. Delete after YCM works. TODO: Do I have to delete this? i remember it not working if deleted??
Plugin 'rking/ag.vim'                               " TODO: completely replace with Ack.vim
Plugin 'Chun-Yang/vim-action-ag'                    " Let us search for text objects in normal and visual modes
Plugin 'scrooloose/nerdtree'
Plugin 'skwp/greplace.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'                       " Read the docs, this is actually very good
Plugin 'tpope/vim-abolish'                          " Provide useful case-insensistive string replacing operations
Plugin 'tpope/vim-eunuch'                           " Sugar for UNIX commands
Plugin 'tpope/vim-jdaddy'                           " JSON manipulation
Plugin 'tpope/vim-capslock'                         " Software CAPS LOCK: `<C-G>c` in insert mode, `gC` in normal mode
Plugin 'godlygeek/tabular'                          " Aligning
Plugin 'vim-syntastic/syntastic'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mattn/emmet-vim'
Plugin 'Valloric/YouCompleteMe'                     " Run `./install.py --with-tern-completer` or something after installation
Plugin 'ternjs/tern_for_vim'                        " Run `npm install` inside it's folder after installation
Plugin 'easymotion/vim-easymotion'                  " Move through file using letters instead of numbers
Plugin 'flowtype/vim-flow'                          " Flow type. TODO: is this already in polyglot???
Plugin 'AndrewRadev/splitjoin.vim'                  " Split and join with gS and gJ
Plugin 'mileszs/ack.vim'                            " Use Ack
Plugin 'rakr/vim-one'                               " colorscheme `one`

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

