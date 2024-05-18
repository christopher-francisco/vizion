local M = {}

---@class Mapping
---@field mode string|table
---@field lhs string
---@field rhs string|function
---@field desc? string

---@type Mapping[]
M.keys = {
  { mode = "n",           lhs = "gd",             rhs = vim.lsp.buf.definition,         desc = "Goto definition" }, -- FIXME: telescope?
  { mode = "n",           lhs = "K",              rhs = vim.lsp.buf.hover,              desc = "Hover" },
  { mode = { "n", "v" },  lhs = "<leader>ca",     rhs = vim.lsp.buf.code_action,        desc = "Code Action",  },
  { mode = "n",           lhs = "[d",             rhs = vim.diagnostic.goto_prev,       desc = "Goto previous" },
  { mode = "n",           lhs = "]d",             rhs = vim.diagnostic.goto_next,       desc = "Goto next" },
}

---@param buffer number
function M.on_attach(_, buffer)
  local opts = {
    silent = true,
    buffer = buffer
  }

  for _, keys in pairs(M.keys) do
    vim.keymap.set(keys.mode, keys.lhs, keys.rhs, opts)
  end
end

return M

