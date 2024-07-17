local colorscheme = require('utils.colorscheme').colorscheme
vim.cmd.colorscheme(colorscheme)

local opt = vim.opt

-- ui
opt.background = vim.env.THEME or "dark"
opt.cmdheight = 1
opt.laststatus = 3
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
-- TODO: figureout the statuscolumn
-- opt.statuscolumn = [[%!v:lua.require'utils.ui'.statuscolumn()]]
opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s%C"
opt.termguicolors = true
opt.virtualedit = "block"

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
opt.spelllang = { "en" }opt.spelloptions:append("noplainbuffer")
opt.spelloptions:append("noplainbuffer")

-- format
opt.formatexpr = "v:lua.require'conform'.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj

-- folds
opt.foldexpr = "v:lua.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldnestmax = 4
opt.foldtext = ""

-- search
opt.ignorecase = true
opt.smartcase = true

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

-- Misc
opt.updatetime = 300
