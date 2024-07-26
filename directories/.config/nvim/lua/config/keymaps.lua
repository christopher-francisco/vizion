local remove_buffer = require('utils.buffers').remove_buffer
local save_session = require('utils.sessions').save
local load_session = require('utils.sessions').load

local M = {}

local map = vim.keymap.set

-- Config files
map("n", "<leader>ftc", ":e ~/.config/tmux/tmux.conf<cr>", { desc = "Open Tmux config" })

-- Sessions
map("n", "<leader>SS", save_session, { desc = "Save session" })
map("n", "<leader>SL", load_session, { desc = "Load session" })

-- Move up/down including wrapped lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
-- TODO: Delete them as they are already handled by vim-tmux-navigator keys
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize Window
map("n", "<A-k>", "<cmd>resize +5<cr>", { desc = "Increase Window Height" })
map("n", "<A-j>", "<cmd>resize -5<cr>", { desc = "Decrease Window Height" })
map("n", "<A-l>", "<cmd>vertical resize -5<cr>", { desc = "Decrease Window Width" })
map("n", "<A-h>", "<cmd>vertical resize +5<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "]l", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "[l", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "]l", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "[l", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<leader>bD", remove_buffer, { desc = "Delete Buffer but keep Window" })
map("n", "<leader>b%", ":%bd<cr>", { desc = "Delete all buffers" })

-- Write (Save)
map("n", "<leader>ww", ":w<cr>", { desc = "Write buffer" })
map("n", "<leader>wbd", ":w|q<cr>", { desc = "Write, then Quit / close Window" })
map("n", "<leader>wbd", ":w|bd<cr>", { desc = "Write, then delete Buffer and Window" })
map("n", "<leader>wbD", ":echo 'Not yet implemented'", { desc = "Write, then delete Buffer but keep Window" })
map("n", "<leader>wso", ":w|so<cr>", { desc = "Write and source" })

-- Quit
map("n", "Q", ":q<cr>", { desc = "Quit / close window" })

-- Better join
map("n", "J", "mzJ`z", { desc = "Join, keep cursor position" })

map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute preloaded" })
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg - use when LSP is attached" })

-- Movement
-- TODO: Delete as these are not as useful
-- map("n", "<c-d>", "<c-d>zz", { desc = "Scroll down, center" })
-- map("n", "<c-u>", "<c-u>zz", { desc = "Scroll up, center" })
-- map("n", "n", "nzzzv", { desc = "Go to next, center" })
-- map("n", "N", "Nzzzv", { desc = "Go to next, center" })

-- Clear search
map("n", "<cr>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Add undo break-points
--[[  Not sure what is this for?  DAP maybe?
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
]]
   --

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Files
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>_f", ':sp <c-r>=expand("%:p:h")<cr>/', { desc = "Open file in split" })
map("n", "<leader>|f", ':vsp <c-r>=expand("%:p:h")<cr>/', { desc = "Open file in split" })
map("n", "<leader><tab>f", ':tabe<c-r>=expand("%:p:h")<cr>/', { desc = "Open file in split" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Quickfix
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Next Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Previous Diagnostic" })
map("n", "[e", function() vim.diagnostic.goto_prev({ severity = "ERROR" }) end, { desc = "Next Error" })
map("n", "]e", function() vim.diagnostic.goto_next({ severity = "ERROR" }) end, { desc = "Previous Error" })
map("n", "[w", function() vim.diagnostic.goto_prev({ severity = "WARN" }) end, { desc = "Next Warning" })
map("n", "]w", function() vim.diagnostic.goto_next({ severity = "WARN" }) end, { desc = "Previous Warning" })

-- Window
map("n", "<leader>-", "<c-w>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>\\", "<c-w>v", { desc = "Split Window Right", remap = true })

-- Tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "[T", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "]T", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)


---@param buffer number
function M.on_attach(_, buffer)
  map("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Goto definition", buffer = buffer, silent = true })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = buffer, silent = true })
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = buffer, silent = true })

  -- TODO: take a look at these for LSP
  --[[
  --wk.register({
           K = {"<cmd>lua vim.lsp.buf.hover()<cr>", "LSP hover info"},
           gd = {"<cmd>lua vim.lsp.buf.definition()<cr>", "LSP go to definition"},
           gD = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "LSP go to declaration"},
           gi = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "LSP go to implementation"},
           gr = {"<cmd>lua vim.lsp.buf.references()<cr>", "LSP list references"},
           gs = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "LSP signature help"},
           gn = {"<cmd>lua vim.lsp.buf.rename()<cr>", "LSP rename"},
           ["[g"] = {"<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to previous diagnostic"},
           ["g]"] = {"<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next diagnostic"},
         }, {
  ]]--
end

return M
