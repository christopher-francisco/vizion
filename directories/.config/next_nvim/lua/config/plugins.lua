local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Defile FileLoad event
local Event = require("lazy.core.handler.event")
Event.mappings.FileLoad = { id = "FileLoad", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
Event.mappings["User FileLoad"] = Event.mappings.FileLoad

require("lazy").setup({
  spec = {
    { import = "plugins" }
  },
  install = {
    colorscheme = { "everforest" }
  },
  -- checker = {
  --   enabled = false,
  --   notify = false,
  -- },
  change_detection = {
    enabled = true,
    notify = false,
  },
})
