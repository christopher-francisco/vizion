set nocompatible              				" We want the latest Vim settings

so ~/.vim/plugs.vim

syntax enable
set backspace=indent,eol,start				" Make backspace behave normally.
let mapleader=','					" The default is \, but a comma is better.
set number						" Show line number.
set noerrorbells visualbell t_vb=			" No bells when pressing wrong key.
set autowriteall 					" Automatically write the file when switching buffers.
set complete=.,w,b,u 					" TODO: do we need this with YCM? - Set our desiring autocompletion matching.
set expandtab                                           " Use spaces instead of tabs
set tabstop=2                                           " The width of the tab key
set softtabstop=2                                       " Width of indent in insert mode
set shiftwidth=0                                        " Width of indent in normal mode
set autoindent                                          " New line keeps current indentation
set autoread                                            " Reload when changed on disk
set nobackup                                            " We don't want backups
set noswapfile                                          " We don't want swap files
set cursorline                                          " We want to highlight the cursor horizontally
set encoding=UTF-8
set signcolumn=yes                                      " Always show the gutter

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
set nocursorline
set lazyredraw
" set ttyfast


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

" let g:rigel_airline = 1
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

" gui_running not working on nvim
hi vertsplit guifg=bg guibg=#363C48

" Get rid of split borders on terminal vim
" Gets rid of the horizontal bar when splitting windows
if has("gui_running")
    hi LineNr guibg=bg
    " hi vertsplit guifg=bg guibg=bg
    " hi vertsplit guifg=bg guibg=#272C35
    hi vertsplit guifg=bg guibg=#363C48
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





"---------------------- Other options ----------------------
" We want to use ripgrep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case





"-------------------- Mappings --------------------
" Back to normal mode from insert mode
inoremap jk <Esc>
inoremap kj <Esc>

" Make it easy to edit the .vimrc file
" nmap <Leader>ve :tabedit $MYVIMRC<cr>
nmap <Leader>ve :tabedit ~/.vimrc<cr>
nmap <Leader>vp :tabedit ~/.vim/plugs.vim<cr>

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

" Find FIXMEs quickly
nmap <Leader>fm :Rg FIXME<cr>




"-------------------- Plugins --------------------
set wildignore+=*/.git/*,*/tmp/*,*.so,*.swp,*.zip,*.class     " MacOSX/Linux

"/
"/ coc.nvim
"/
set hidden " TextEdit might fail if hidden is not set.
set nobackup " Some servers have issues with backup files, see #649.
set nowritebackup
set cmdheight=2 " Give more space for displaying messages.
set updatetime=300 " Faster experience
set signcolumn=yes " Always show the signcolumn

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"
" Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" jsonc on coc-settings.json
autocmd FileType json syntax match Comment +\/\/.\+$+

" Things to note about coc.nvim
"   * Must 'confirm completion' in order for auto-import to work `<C-y>`.
"   * Run `:CocRebuild` after upgrading node to rebuild modules.
"   * Use `CocList diagnostics` instead of location lists
"   * Use `set signcolumn=auto:2` or `"diagnostic.signOffset": 9999999`
"     to make coc signs higher priority

" Use coc-diagnostics for linting and formatting with eslint/prettier

" let g:ycm_error_symbol = '✘'
" let g:ycm_warning_symbol = '⚠'

" nmap <Leader>gt :YcmCompleter GoTo<cr>
" nmap <Leader>gr :YcmCompleter GoToReferences<cr>
" nmap <Leader>rn :YcmCompleter RefactorRename 
" nmap <Leader>fi :YcmCompleter FixIt<cr>

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

"
"/
"/ editorconfig-vim
"/
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

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

function! GetGitHubInstance()
    let github = $GITHUB_INSTANCE

    if (github != "") 
        let text = github
    else
        let text = ""
    endif

    return text
endfunction

" TODO: wrap this 2 alls in a check if airlines is already installed
call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})

call airline#parts#define_function('github-instance', 'GetGitHubInstance')


function! AirlineInit()
    let g:airline_section_b = airline#section#create_left(['github-instance', 'hunks', 'branch'])
    let g:airline_section_z = airline#section#create(['%3p%%: ', 'linenr', ':%3v'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

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
"/ vim-polyglot
"/
let g:polyglot_disabled = ['tmux']

"/
"/ tagbar
"/
" Focus the tag bar when opening it
let g:tagbar_autofocus = 1 

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
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!{.git,node_modules}"'
" nmap <C-p><C-p> :Files<cr>
nmap <C-p><C-p> :call FZFWithDevIcons()<cr>
nmap <C-space> :call FZFWithDevIcons()<cr>
nmap <C-p><C-t> :BTags<cr>

"/ @see https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

map <space> :RG<CR>

"/
"/ vim-devicons
"/
" https://github.com/ryanoasis/vim-devicons/issues/106#issuecomment-578685009
function! FZFWithDevIcons()
  let l:fzf_files_options = ' -m --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up --preview "bat --color always --style numbers {2..}"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND.'| devicon-lookup'), '\n')
    return l:files
  endfunction

  function! s:edit_file(items)
    let items = a:items
    let i = 1
    let ln = len(items)
    while i < ln
      let item = items[i]
      let parts = split(item, ' ')
      let file_path = get(parts, 1, '')
      let items[i] = file_path
      let i += 1
    endwhile
    call s:Sink(items)
  endfunction

  let opts = fzf#wrap({})
  let opts.source = <sid>files()
  let s:Sink = opts['sink*']
  let opts['sink*'] = function('s:edit_file')
  let opts.options .= l:fzf_files_options
  call fzf#run(opts)
endfunction

"/
"/ ale
"/
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

let g:ale_fixers = {
\ 'javascript': ['eslint', 'prettier'],
\ 'typescript': ['eslint', 'prettier'],
\ 'scss': ['stylelint'],
\}

let g:ale_linters = {
\ 'typescript': ['eslint'],
\ 'javascript': ['eslint'],
\ 'scss': ['stylelint'],
\ 'cucumber': ['gherkin-lint'],
\ 'feature': ['gherkin-lint'],
\ 'gherkin': ['gherkin-lint'],
\}

let g:ale_fix_on_save = 0

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_fixers_explicit = 1

"/
"/ vim-gitgutter
"/


"/
"/ vim-tmux-navigator
"/
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1





"-------------------- Auto-Commands --------------------
"
autocmd BufNewFile,BufRead Dockerfile* set filetype=Dockerfile
autocmd BufNewFile,BufRead *tmux.conf* set filetype=tmux
autocmd BufNewFile,BufRead *nginx.conf* set filetype=nginx
autocmd BufNewFile,BufRead .env* set filetype=sh
autocmd BufNewFile,BufRead *.snippets set list
autocmd BufNewFile,BufRead .env-cmdrc set filetype=json
autocmd BufNewFile,BufRead .gitconfig* set filetype=gitconfig

" Automatically source the .vimrc file on save
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc,.gvimrc source % | AirlineRefresh
augroup end




"-------------------- Functions --------------------
function Pnpm(cmd, package, ...)
  let cmd = a:cmd
  let package = a:package
  let dir = " -C " . expand('%:h') . " "
  let flags = ''

  if len(a:000)
    let flags = " " . join(a:000)
  endif

  let cmd = "pnpm " . cmd . dir . package . flags

  execute "!".cmd
endfunction

command! -nargs=* Pnpm call Pnpm(<f-args>)




"------------------------- Local Configuration ------------------------
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif




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
