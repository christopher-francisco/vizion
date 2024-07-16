vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local M = {}

function M.setup()
  require("config.plugins")
  require("config.set")
  require("config.keymaps").setup()
  require("config.cmd")
end

return M
