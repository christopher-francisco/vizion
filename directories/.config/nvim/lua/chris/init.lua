vim.g.mapleader = ","

local M = {}

function M.setup()
  require("chris.plugins")
  require("chris.set")
  require("chris.remap")
  require("chris.cmd")
end

return M
