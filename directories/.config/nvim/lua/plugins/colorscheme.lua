return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "moon"
    },

    config = function()
      --vim.cmd([[colorscheme tokyonight]])
    end

  },
  {
    "catppuccin/nvim",
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
  }
}
