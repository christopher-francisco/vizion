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
set mouse=a
set nobackup                                            " We don't want backups
set noswapfile                                          " We don't want swap files
set cursorline                                          " We want to highlight the cursor horizontally
set cursorcolumn                                        " We want to highlight the cursor vertically




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
set hlsearch                                            " Highlight all matched terms.
set incsearch                                           " Incrementally highlight as we type.





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
imap jk <esc>

" Make it easy to edit the .vimrc file
nmap <Leader>v :tabedit $MYVIMRC<cr>
nmap <Leader>s :e ~/.vim/snippets/

" Add highlight removal
nmap <Leader><space> :nohlsearch<cr>

" Quickly browse any tag/symbol in the project.
" Tip: run `ctags -R` to regenerate the index.
nmap <Leader>f :tag<space>

" Sort PHP use statements
" See: http://stackoverflow.com/questions/11531073/how-do-you-sort-a-range-of-lines-by-length
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>

" Write to a file faster
nmap <Leader>wf :w<cr>

" Quits a window faster
nmap <Leader>q :q<cr>

" Saves and quit
nmap <Leader>x :x<cr>

" Enable folding by indent on the current file
function! Fold()
    let previous_method = &fdm

    if previous_method ==? "manual"
        setlocal fdm=syntax
    else
        setlocal fdm=manual
    endif
endfunction




"-------------------- Plugins --------------------
"/
"/ CtrlP
"/
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_show_hidden = 1

" let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|dist\|vendor\|log$\|tmp\|javadoc\|bundle\|plugged$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

let g:ctrlp_map = '<c-p><c-p>'
nmap <C-p><C-e> :CtrlPBufTag<cr>
nmap <C-p><C-m> :CtrlPMRUFiles<cr>

let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20,results:20'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40



"/
"/ NerdTree
"/
let NERDTreeHijackNetrw = 0                             " Prevent NERDTree to conflict with vinegar.vim
let NERDTreeShowHidden = 1                              " Show hidden files
let NERDTreeIgnore = ['\.DS_Store$']                    " Hide files with .DS_Store extension

"Make NERDTree easier to toggle.
nmap <D-1> :NERDTreeToggle<cr>
nmap <C-n> :NERDTreeToggle<cr>

"/
"/ Greplace.vim
"/
set grepprg=ag                                          " Use Ag for search

let g:grep_cmd_opts = '--line-numbers --noheading'

"/
"/ vim-php-cs-fixer.vim
"/
let g:php_cs_fixer_level = "psr2"
let g:php_cs_fixer_verbose = 1

nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>

"/
"/ pdv
"/
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>

"/
"/ Ultisnips
"/
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

"/
"/ syntastic
"/
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
" let g:syntastic_javascript_flow_exe = '$(npm bin)/flow'
" let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_blade_checkers = []
let g:syntastic_html_checkers=['']
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
let g:EditorConfig_core_mode = 'external_command'

"/
"/ vim-airline
"/
let g:airline#extensions#branch#enabled = 1                                                         " We want the Git branch to show
set noshowmode                                                                                      " We don't want to show the --INSERT-- message when on insert mode
set laststatus=2                                                                                    " We want the status bar to always appear
" let g:airline_theme='solarized'

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

" augroup javascript_folding
"     au!
"     au FileType javascript setlocal foldmethod=syntax
" augroup END

"/
"/ vim-flow
"/
let g:flow#enable = 0
let g:flow#autoclose = 1

" Use locally installed flow
" see: https://github.com/flowtype/vim-flow/issues/24
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

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
let g:github_enterprise_urls = ['https://github.anaplan.com']

"/
"/ vim-polyglot
"/
let g:polyglot_disabled = ['tmux']




"-------------------- Auto-Commands --------------------
"
autocmd BufNewFile,BufRead Dockerfile* set filetype=Dockerfile
autocmd BufNewFile,BufRead *tmux.conf* setf tmux
autocmd BufNewFile,BufRead *nginx.conf* setf nginx
autocmd BufNewFile,BufRead .env* set filetype=sh

" Automatically source the .vimrc file on save
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc,.gvimrc source % | AirlineRefresh
augroup end





"-------------------- Functions --------------------

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
