local M = {}

M.debuggers_root = vim.loop.os_homedir() .. '/Developer/tools'

function M.setup_codelldb()
  local xcodebuild = require("xcodebuild.integrations.dap")
  local codelldbPath = M.debuggers_root .. "/codelldb-aarch64-darwin/extension/adapter/codelldb"

  xcodebuild.setup(codelldbPath)
end

return M
