local M = {}

---@class Mapping
---@field mode string|table
---@field lhs string
---@field rhs string|function
---@field desc? string

---@return Mapping[]
function M.getKeys()
  return {
    { mode = "n",          lhs = "gd",         rhs = function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,   desc = "Goto definition" },
    { mode = "n",          lhs = "K",          rhs = vim.lsp.buf.hover,        desc = "Hover" },
    { mode = { "n", "v" }, lhs = "<leader>ca", rhs = vim.lsp.buf.code_action,  desc = "Code Action", },
    { mode = "n",          lhs = "[d",         rhs = vim.diagnostic.goto_prev, desc = "Goto previous" },
    { mode = "n",          lhs = "]d",         rhs = vim.diagnostic.goto_next, desc = "Goto next" },
    { mode = "n",          lhs = "<leader>f",  rhs = vim.lsp.buf.format,       desc = "Format code" },
  }
end

---@param buffer number
function M.on_attach(_, buffer)
  local opts = {
    silent = true,
    buffer = buffer
  }

  for _, keys in pairs(M.getKeys()) do
    local mergedOpts = vim.tbl_deep_extend("force", opts, { desc = keys.desc })
    vim.keymap.set(keys.mode, keys.lhs, keys.rhs, mergedOpts)
  end
end

return M
