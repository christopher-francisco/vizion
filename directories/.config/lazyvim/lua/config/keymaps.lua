-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- LazyVim maps <leader>ft to Terminal (Root Dir), blocking our <leader>ftc/<leader>ftf sub-prefix
vim.keymap.del("n", "<leader>ft")

-- Delete LazyVim's <C-s> save shortcut — using <leader>ww instead
vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")

-- Delete LazyVim's <Esc> hlsearch clear (normal mode) — using <cr> instead
vim.keymap.del("n", "<Esc>")

-- Move lines with ]l/[l in normal mode only (LazyVim's <A-j>/<A-k> handle insert/visual)
map("n", "]l", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "[l", "<cmd>m .-2<cr>==", { desc = "Move Up" })

-- <leader>bb is identical in LazyVim; omitted
-- <leader>K is identical in LazyVim; omitted
-- gco/gcO are identical in LazyVim; omitted

-- Extra buffer ops
map("n", "<leader>b%", "<cmd>%bd<cr>", { desc = "Delete All Buffers" })

-- Write shortcuts
map("n", "<leader>ww", "<cmd>w<cr>", { desc = "Write Buffer" })
map("n", "<leader>wa", "<cmd>wa<cr>", { desc = "Write All Buffers" })
map("n", "<leader>wbd", "<cmd>w|q<cr>", { desc = "Write and Quit" })
map("n", "<leader>wbD", "<cmd>w|bd<cr>", { desc = "Write and Delete Buffer" })
map("n", "<leader>wso", "<cmd>w|so<cr>", { desc = "Write and Source" })

-- Quit shortcut
map("n", "Q", "<cmd>q<cr>", { desc = "Quit" })

-- Join keep cursor position
map("n", "J", "mzJ`z", { desc = "Join Lines" })

-- Substitute with word under cursor preloaded
map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute Word" })

-- Clear search on <cr>
map("n", "<cr>", "<cmd>noh<cr>", { desc = "Clear hlsearch" })

-- Session (persistence.nvim is LazyVim built-in; <leader>qs deleted in plugins/editor.lua)
map("n", "<leader>SS", function() require("persistence").save() end, { desc = "Save Session" })
map("n", "<leader>SL", function() require("persistence").load() end, { desc = "Load Session" })

-- Config / file shortcuts
map("n", "<leader>ftc", "<cmd>e ~/.config/tmux/tmux.conf<cr>", { desc = "Open Tmux Config" })
map("n", "<leader>fp", function() print(vim.fn.expand("%")) end, { desc = "Display File Path" })
map("n", "<leader>_f", "<cmd>sp <c-r>=expand('%:p:h')<cr>/<cr>", { desc = "Open File in Split" })
map("n", "<leader>|f", "<cmd>vsp <c-r>=expand('%:p:h')<cr>/<cr>", { desc = "Open File in Vertical Split" })

-- FIXME to quickfix
map("n", "<leader>xft", "<cmd>grep -t ts FIXME<cr>", { desc = "FIXME (TS) to Quickfix" })

-- Split right with <leader>\ (delete LazyVim's <leader>| which does the same)
vim.keymap.del("n", "<leader>|")
map("n", "<leader>\\", "<c-w>v", { desc = "Split Window Right" })

-- Open file in new tab
map("n", "<leader><tab>f", "<cmd>tabe <c-r>=expand('%:p:h')<cr>/<cr>", { desc = "Open File in New Tab" })

-- Quickfix first/last (LazyVim has [q/]q for prev/next but not first/last)
map("n", "[Q", vim.cmd.cfirst, { desc = "First Quickfix" })
map("n", "]Q", vim.cmd.clast, { desc = "Last Quickfix" })

-- Tab navigation with ]t/[t (delete LazyVim's <leader><tab>]/[ equivalents)
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>[")
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })

-- Tab first/last with ]T/[T (delete LazyVim's <leader><tab>f/l equivalents)
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab>l")
map("n", "]T", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "[T", "<cmd>tabfirst<cr>", { desc = "First Tab" })
