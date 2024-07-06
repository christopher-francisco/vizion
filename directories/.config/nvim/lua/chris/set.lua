local opt = vim.opt

opt.number = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 0
opt.expandtab = true

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.treesitter.foldexpr()"
opt.foldtext = ""
-- opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 4

opt.wrap = false

-- opt.autoindent = true
-- opt.autoread = true
opt.swapfile = false
opt.backup = false

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.cmdheight = 2

opt.updatetime = 300

opt.splitbelow = true
opt.splitright = true
opt.background = vim.env.THEME or "dark"
