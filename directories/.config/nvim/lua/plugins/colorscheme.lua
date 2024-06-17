return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = true,
    priority = 1000,
    opts = {
      style = "moon"
    },
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end

  },
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      background = {
        light = "latte",
        dark = "mocha",
      }
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    "neanias/everforest-nvim",
    enabled = false,
    version = false,
    lazy = false,
    priority = 2000, -- make sure to load this before all the other start plugins
    init = function()
      vim.cmd.colorscheme("everforest")
    end,
    config = function ()
      require("everforest").setup({
        background = "soft",
        italics = true,
      })
    end
  },
  {
    "sainnhe/everforest",
    enabled = true,
    lazy = false,
    priority = 2100,
    config = function ()
      vim.g.everforest_background = "soft"
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme("everforest")
    end
  }
}
