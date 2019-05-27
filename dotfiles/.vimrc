set nocompatible              				" We want the latest Vim settings

so ~/.vim/plugs.vim

syntax enable
set backspace=indent,eol,start				" Make backspace behave normally.
let mapleader=','					" The default is \, but a comma is better.
set number						" Show line number.
set noerrorbells visualbell t_vb=			" No bells when pressing wrong key.
set autowriteall 					" Automatically write the file when switching buffers.
set complete=.,w,b,u 					" TODO: do we need this with YCM? - Set our desiring autocompletion matching.
set tabstop=8                                           " The width of the tab key
set expandtab                                           " Use spaces instead of tabs
set softtabstop=4                                       " Width of indent in insert mode
set shiftwidth=4                                        " Width of indent in normal mode
set autoindent                                          " New line keeps current indentation
set autoread                                            " Reload when changed on disk
set nobackup                                            " We don't want backups
set noswapfile                                          " We don't want swap files
set cursorline                                          " We want to highlight the cursor horizontally

" Mouse
set mouse=nicr
" This was supposed to handle mouse in nvim and vim, but none of it worked and
" then some weird scroll mouse problem appeared. I'll handle this later
" set ttyfast
" if !has('nvim')
    " set ttymouse=xterm2
" endif


" Attempt to make it faster, since it's running slow
" @see https://github.com/tmux/tmux/issues/353
set nonumber
set nocursorline
set lazyredraw
set ttyfast


"-------------------- Visuals --------------------
set t_CO=256						" Use 256 colors on terminal Vim

if (has("termguicolors"))
    " Force true color on since vim can't detect it inside Tmux
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

    " Enable true color. Without the lines above, results in no color when
    " launched inside Tmux.
    set termguicolors
endif

set background=dark
let g:one_allow_italics = 1
colorscheme one

let g:airline_theme='one'

" Disable `~` at end of buffer
highlight EndOfBuffer ctermfg=bg guifg=bg

" Change color of folded lines
" hi Folded guifg=White guibg=#22252a

set guifont=Fira\ Code\ Retina:h14
set linespace=12                                        " Macvim line height

set guioptions-=e					" We don't want Gui tabs.
set guioptions-=l                                       " Disable GUI scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions+=c                                       " We want to get rid of popup bullshit

" hi LineNr ctermbg=none
" hi vertsplit ctermfg=bg ctermbg=bg

" Get rid of split borders on terminal vim
" Gets rid of the horizontal bar when splitting windows
if has("gui_running")
    hi LineNr guibg=bg
    hi vertsplit guifg=bg guibg=bg
    hi foldcolumn guibg=bg

    " hi StatusLine guifg=bg guibg=bg
    " hi StatusLineNC guifg=bg guibg=bg
else
    if exists("bg")
        hi LineNr ctermbg=bg
        hi vertsplit ctermfg=bg ctermbg=bg
        hi foldcolumn ctermbg=bg

        " hi StatusLine ctermfg=bg ctermbg=bg
        " hi StatusLineNC ctermfg=bg ctermbg=bg
    endif
endif

" Changes the `|` character on split windows
set fillchars+=vert:\ 





"-------------------- Search --------------------
" set hlsearch                                            " Highlight all matched terms.
" set incsearch                                           " Incrementally highlight as we type.
set nohlsearch





"-------------------- Split Management --------------------
set splitbelow						" Make splits default to below...
set splitright						" And to the right. This feels more natural.

" Allows easy movement through splits
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Let us move between wrapped lines
nnoremap k gk
nnoremap j gj





"-------------------- Mappings --------------------
" Back to normal mode from insert mode
inoremap jk <Esc>
inoremap kj <Esc>

" Make it easy to edit the .vimrc file
" nmap <Leader>ve :tabedit $MYVIMRC<cr>
nmap <Leader>ve :tabedit ~/.vimrc<cr>

" Write to a file faster
nmap <Leader>w :w<cr>

" Quits a window faster
nmap <Leader>q :q<cr>

" We want to clear highlight search when pressing Enter
" nnoremap <silent> <CR> :noh<CR>

" We want to open files relative to the current file
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>vs :vsplit <C-R>=expand("%:p:h") . "/" <CR>





"-------------------- Plugins --------------------
"/
"/ CtrlP
" @deprecated - uninstalled in favor of FZF
"/
set wildignore+=*/.git/*,*/tmp/*,*.so,*.swp,*.zip,*.class     " MacOSX/Linux

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|dist\|vendor\|log$\|tmp\|javadoc\|bundle\|plugged$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" let g:ctrlp_map = '<c-p><c-p>'
" nmap <C-p><C-e> :CtrlPBufTag<cr>
" nmap <C-p><C-m> :CtrlPMRUFiles<cr>

let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20,results:20'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_show_hidden = 1

" We want to use ripgrep
set grepprg=rg\ --color=never\ --hidden
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching = 0



"/
"/ Ack
"/
let g:ackprg = 'rg --vimgrep'



"/
"/ NerdTree
"/
let NERDTreeHijackNetrw = 0                             " Prevent NERDTree to conflict with vinegar.vim
let NERDTreeShowHidden = 1                              " Show hidden files
let NERDTreeIgnore = ['\.DS_Store$']                    " Hide files with .DS_Store extension

"/
"/ Greplace.vim
"/
" FIXME: this plugin broke after ripgrep update
" let g:grep_cmd_opts = '--line-numbers --noheading'

"/
"/ YouCompleteMe
"/
" let g:loaded_youcompleteme = 1 " tmp disable
let g:ycm_server_python_interpreter = '/usr/local/bin/python3' " We tell YCM to use python3

" We want filepath completion on .jsx files
let g:ycm_filepath_blacklist = {}

" FIXME: This is an attempt to fix the problem where the Esc causes an error about window not closed
" NONEOFTHISWORKED
let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1

" Debugging
let g:ycm_server_keep_log_files = 1
let g:ycm_log_level = 'debug'

nmap <Leader>gt :YcmCompleter GoTo<cr>
nmap <Leader>gr :YcmCompleter GoToReferences<cr>
nmap <Leader>rn :YcmCompleter RefactorRename 
nmap <Leader>fi :YcmCompleter FixIt<cr>

"/
"/ Ultisnips
"/
" Attempting to autocomplete with tab, and navigate ultisnip with Ctrl-J
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Open snippets on a vertical split
let g:UltiSnipsEditSplit='vertical'

" Fixes the problem where snippets are created in the project's directory
" rather than in the root. @see https://github.com/SirVer/ultisnips/issues/711
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

"/
"/ syntastic
"/ FIXME: sourcing multiple times causes this to show "multiple lines"
"/
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_scss_checkers = ['stylelint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_blade_checkers = []
let g:syntastic_html_checkers=[]
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
let g:syntastic_java_checkers = []

function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 10])
    endif
endfunction

"
"/
"/ editorconfig-vim
"/
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
" let g:EditorConfig_core_mode = 'external_command'
let g:EditorConfig_core_mode = 'python_external'

"/
"/ vim-airline
"/
let g:airline#extensions#branch#enabled = 1                                                         " We want the Git branch to show
set noshowmode                                                                                      " We don't want to show the --INSERT-- message when on insert mode
set laststatus=2                                                                                    " We want the status bar to always appear

" Adds comma as thousand separator to the line number, to make them human
" readable
function! MyLineNumber()
  return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). ' | '.
    \    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction

" TODO: wrap this 2 alls in a check if airlines is already installed
call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})

let g:airline_section_z = airline#section#create(['%3p%%: ', 'linenr', ':%3v'])

"/
"/ vim-javascript
"/
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

"/
"/ vim-flow
"/
let g:flow#enable = 0
let g:flow#autoclose = 1

"/
"/ emmet-vim
"/
" Make `.js` files expand `className` instead of `class`
let g:user_emmet_settings = {
\  'javascript': {
\    'attribute_name': {'for': 'htmlFor', 'class': 'className'},
\  },
\}

"/
"/ vim-rhubarb
"/
" TODO: load this from an ENV variable?
let g:github_enterprise_urls = []

"/
"/ vim-polyglot
"/
let g:polyglot_disabled = ['tmux']

"/
"/ tagbar
"/
" FIXME: this isn't working, the plugin isn't even installed
let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'JavaScript',
    \ 'kinds'     : [
        \ 'o:objects',
        \ 'f:functions',
        \ 'a:arrays',
        \ 's:strings'
    \ ]
\ }

"/
"/ vim-markdown-preview
"/
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'

"/
"/ FZF
"/
nmap <C-m><C-m> :Files<cr>
nmap <C-m><C-t> :BTags<cr>




"-------------------- Auto-Commands --------------------
"
autocmd BufNewFile,BufRead Dockerfile* set filetype=Dockerfile
autocmd BufNewFile,BufRead *tmux.conf* setf tmux
autocmd BufNewFile,BufRead *nginx.conf* setf nginx
autocmd BufNewFile,BufRead .env* set filetype=sh
autocmd BufNewFile,BufRead *.snippets set list

" Automatically source the .vimrc file on save
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc,.gvimrc source % | AirlineRefresh
augroup end

augroup custom_commands
    autocmd!
    autocmd VimEnter * if !exists(":Fold") | command Fold execute "call ToggleFold()" | endif
augroup end




"-------------------- Functions --------------------
" Enable folding by indent on the current file
function! ToggleFold()
    let previous_method = &fdm

    if previous_method ==? "manual"
        setlocal fdm=syntax
    else
        setlocal fdm=manual
    endif
endfunction

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>'

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>





" Put 

" Prerequisites
" - Install CTags through homebrew. See https://gist.github.com/nazgob/1570678
"   if it doens't work
" - Install The Silver Searcher through Homebrew
" - Install editorconfig through Homebrew

" -------------------- Notes and Tips --------------------
"  XML
" - `:%s/\(<[^>]*>\)/\1\r/g` to insert newline after every tag

" Command mode
" - `:pwd` Prints current directory
" - `:cwd [dir]` Changes current directory.
" - `:bufdo bd!` closes all buffer
" - `:tabn` or `:tabe` opens a new tab
" - `:ls` list all buffers
" - `:bd` destroy current buffer
" - `:bd [index]` destroy buffer on index
" - `sbuffer [index]` opens a split window with that loaded buffer
" - `:q` closes window, but buffer is still there
" - `:/ + ctrl + R + "` paste what was last yanked in command mode
" - `:marks` Lists all marks.
" - `:bp` Return to previous buffer.
" - `:wa` Write all files.

" Normal mode
" - 'zz' Center the line where the cursor is located.
" - `gt` Switche between tabs.
" - `ctrl + ^` Return to previous buffer.
" - `ctrl + u` Scroll half a screen upwards.
" - `ctrl + d` Scroll half a screen downwards.
" - `va{` Select the parentensis too.
" - `ctrl + w + o` Make current buffer fullscreen (from split).
" - `J` Join the current line with the next one.
" - `ctrl + o` Jump back.
" - `ctrl + i` Jump forward.
" - `.` Repeat last operation.
" - `?` Search above the current line.
" - `m[lower_letter]` Create a mark on the current buffer (i.e: `mm`).
" - `m[capital_letter]` Create a mark on any file (i.e: `mM`).
" - `'[letter]` Return to a mark.
" - ``[letter]` Return to a mark, to the exact column.
" - ``0` Return to your last file through a mark.
" - `q[key]` Start recording a macro (i.e: `qq`)
" - `q` Stop recording.
" - `co` Open the code fold.

" Vinegar
" - `-` Go to current directory
" - `%` Create a new file
" - `d` Create a new directory
" - `D` Delete a file or directory

" CtrlP
" - `:tag [name]` Go to tag.
" - `:tn` Navigate to next tag.
" - `:tp` navigate to previous tag.
" - `:ts` Select between tags.
" - `ctrl + ]` Navigate to ctag on the selected cursor.

" Ag
" - `:Ag 'foo'` Search in the whole project.

" Gsearch
" 1. Select all lines to change.
" 2. `>s/oldstring/newstring`.
" 3. `Greplace`.
" 4. `a` to accept all replacements.
" 5. `wa` write to all files.

" - Tpope Surrounidngs
" - `cs'"` Change surrounding `'` for `"`.
" - `ds'` Delete surrounding `'`.
" - `dst` Delete the surrounding tag, like HTML tag.
" - `cst` Change surrounding tag for the new input one. Supports class attribute.
" - `S` in `visual mode` and then write tag.

" PHP namespace
" - `,n` Add a `use` statement.
" - `,fn` Expand a class' FQNS.
" - `,su` in `visual mode` to sort from shorter to longer.

" PSR-2
" - `fabpot/php-cs-fixer` through composer global install
" - `,pf` to format using psr-2


" Default OS X `Keyboard repeat` values
" - Key repeat: 7
" - Delay until repeat: 3
"
" f<char> to look forward
" F<char> to look back
" ; to look in same direction
" , to look in opposite direction
"
" When on insert mode `jk` to Escape and immediately `l` to go to the 
" previous spot. That is `jkl`

" Cycling
" We use Tab and S-Tab for cycling between completion list
" We use C-j to expand an Ultisnip snippet
" We use C-j and C-k to move between Ultisnips tabstops

" Project search & replace
" :args *.txt
" :vimgrep /Vimcasts\.\zscom/g ##
" :cdo %s/Vimcasts\.\zscom/org/ge
" :cdo update
