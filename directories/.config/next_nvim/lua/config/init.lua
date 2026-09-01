vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local M = {}

function M.setup()
  require("config.autocmds")
  require("config.plugins")
  require("config.options")
  require("config.keymaps")
end

return M
