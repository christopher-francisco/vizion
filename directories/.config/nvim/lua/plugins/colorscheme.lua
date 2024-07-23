local funcs = require('utils.colorscheme')

local should_lazy_load = funcs.should_lazy_load
local get_priority = funcs.get_priority
local get_event = funcs.get_event

return {
  {
    "folke/tokyonight.nvim",
    lazy = should_lazy_load('tokyonight'),
    priority = get_priority('tokyonight'),
    event = get_event('tokyonight'),
    opts = {
      style = "moon"
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = should_lazy_load('catppuccin'),
    priority = get_priority('catppuccin'),
    event = get_event('catppuccin'),
    opts = {
      background = {
        light = "latte",
        dark = "mocha",
      }
    },
  },
  -- {
  --   "sainnhe/everforest",
  --   name = "everforest-vim",
  --   lazy = should_lazy_load('everforest-vim'),
  --   priority = get_priority('everforest-vim'),
  --   event = get_event('everforest-vim'),
  --   config = function ()
  --     vim.g.everforest_background = "soft"
  --     vim.g.everforest_enable_italic = true
  --   end
  -- },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = should_lazy_load('everforest'),
    priority = get_priority('everforest'),
    event = get_event('everforest'),
    config = function ()
      require('everforest').setup({
        background = "soft",
        italics = true,
        on_highlights = function(hl, palette)
          hl.DashboardHeader = { fg = palette.green }
        end,
      })
    end
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = should_lazy_load('everforest'),
    priority = get_priority('everforest'),
    event = get_event('everforest'),
    opts = {
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
    },
  },
}
