local M = {}

---@class ChrisKeymap
---@field mode string|table
---@field lhs string
---@field rhs string|function
---@field desc? string

---Defines LSP keymaps
---@return ChrisKeymap[]
function M.getLspKeymaps()
  return {
    { mode = "n",          lhs = "gd",         rhs = function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,   desc = "Goto definition" },
    { mode = "n",          lhs = "K",          rhs = vim.lsp.buf.hover,                                                 desc = "Hover" },
    { mode = { "n", "v" }, lhs = "<leader>ca", rhs = vim.lsp.buf.code_action,                                           desc = "Code Action", },
    { mode = "n",          lhs = "[d",         rhs = vim.diagnostic.goto_prev,                                          desc = "Goto previous" },
    { mode = "n",          lhs = "]d",         rhs = vim.diagnostic.goto_next,                                          desc = "Goto next" },
  }
end

---Return general keymaps. Note: tmux-vim-navigator adds split navigation keymaps, so we don't add them here
---@return ChrisKeymap[]
function M.getGeneralKeymaps()
  return {
    -- insert mode
    { mode = "i",          lhs = "jk",                rhs = "<Esc>",                                                      desc = "Leave Insert" },
    { mode = "i",          lhs = "kj",                rhs = "<Esc>",                                                      desc = "Leave Insert" },

    -- normal mode
    { mode = "n",          lhs = "-",                 rhs = vim.cmd.Ex,                                                   desc = "Open Explorer" },
    { mode = "n",          lhs = "<leader>w",         rhs = vim.cmd.w,                                                    desc = "Write file" },
    { mode = "n",          lhs = "<c-d>",             rhs = "<c-d>zz",                                                    desc = "Scroll down, center" },
    { mode = "n",          lhs = "<c-u>",             rhs = "<c-u>zz",                                                    desc = "Scroll up, center" },
    { mode = "n",          lhs = "J",                 rhs = "mzJ`z",                                                      desc = "Join, keep cursor position" },
    { mode = "n",          lhs = "n",                 rhs = "nzzzv",                                                      desc = "Go to next, center" },
    { mode = "n",          lhs = "N",                 rhs = "Nzzzv",                                                      desc = "Go to previous, center" },
    { mode = "n",          lhs = "<leader>ss",        rhs = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],       desc = "Substitute, preload" },
    --[[
    { mode = "n",          lhs = "<leader>sh",        rhs = "<cmd>sp c-r>=expand('%:p:h') . '/' <cr>",                                     desc = "Split horizontal, directory" },
    { mode = "n",          lhs = "<leader>sv",        rhs = "<cmd>vsp <c-r>=expand('%:p:h') . '/' <cr>",                                     desc = "Split horizontal, directory" },
    { mode = "n",          lhs = "<leader>e",         rhs = "<cmd>e <C-R>=expand('%:p:h') . '/' <CR>",                                     desc = "Split horizontal, directory" },
    ]]--

    -- visual mode
    { mode = "v",          lhs = "J",                 rhs = ":m '>+1<CR>gv=gv'", desc = "Move selection down" },
    { mode = "v",          lhs = "K",                 rhs = ":m '<-2<CR>gv=gv'", desc = "Move selection up" },
  }
end


---Calls vim.keymap.set with the specificed keys
---@param keymaps ChrisKeymap[]
function M.register(keymaps, opts)
  for _, keymap in pairs(keymaps) do
    local mergedOpts = vim.tbl_deep_extend("force", opts, { desc = keymap.desc })
    vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, mergedOpts)
  end
end

---Exclusively for attaching to a buffer
---@param buffer number
function M.on_attach(_, buffer)
  local opts = {
    silent = true,
    buffer = buffer
  }

  M.register(M.getLspKeymaps(), opts)
end

function M.setup()
  M.register(M.getGeneralKeymaps(), {})
end

return M
