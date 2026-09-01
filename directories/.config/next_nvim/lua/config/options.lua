local colorscheme = require('utils.colorscheme').colorscheme
vim.cmd.colorscheme(colorscheme)

local opt = vim.opt

-- ui
opt.background = vim.env.THEME or "dark"
opt.cmdheight = 0
opt.conceallevel = 2       -- hide * markup for bold/italic (render-markdown uses this)
opt.confirm = true         -- confirm instead of error on unsaved exit
opt.cursorline = true
opt.laststatus = 3
opt.list = true            -- show invisible characters (tabs, trailing spaces)
opt.mouse = "a"
opt.number = true
opt.pumblend = 10          -- popup transparency
opt.pumheight = 10         -- max popup entries
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 4
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s%C"
opt.termguicolors = true
opt.timeoutlen = 300       -- snappier which-key trigger
opt.virtualedit = "block"
opt.fillchars = {
  foldopen  = "",
  foldclose = "",
  fold      = " ",
  foldsep   = " ",
  diff      = "╱",
  eob       = " ",
}

-- windows
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.winminwidth = 5

-- editor
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 0
opt.softtabstop = 2
opt.smartindent = true
opt.tabstop = 2
opt.wrap = false

-- spell
opt.spelllang = { "en" }
opt.spelloptions:append("noplainbuffer")

-- format
opt.formatexpr = "v:lua.require'conform'.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj

-- folds
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldnestmax = 10
opt.foldtext = ""

-- search / substitute
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"  -- live preview of :s substitutions

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep --hidden"

-- files
opt.autowrite = true
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000

-- cmd
opt.wildmode = "longest,full"

-- session
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- don't sync clipboard in SSH (OSC 52 handles it there)
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

-- Misc
opt.jumpoptions = "view"        -- keep view position when jumping (Neovim 0.10+)
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.smoothscroll = true         -- native smooth scroll (Neovim 0.10+)
opt.updatetime = 200
