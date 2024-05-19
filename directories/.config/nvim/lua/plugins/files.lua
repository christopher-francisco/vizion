return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        {
          "<leader>ls",
          function()
            builtin.buffers({
              sort_mru = true,
              sort_lastused = true,
              ignore_current_buffer = true
            })
          end,
          desc = "Switch Buffer",
        },
        {
          "<leader>lf",
          require("telescope.builtin").git_files,
          desc = "List git files",
        },
        {
          "<leader>lr",
          function()
            require("telescope.builtin").oldfiles()
          end,
          desc = "List files",
        },
        {
          "<leader>laf",
          function()
            require("telescope.builtin").find_files()
          end,
          desc = "List all files",
        },
      }
    end,
    -- We don't use opts because we need a reference to actions and telescope for each individual option
    config = function()
      local telescope = require("telescope")
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            },
            n = {
              q = actions.close,
            }
          }
        }
      })
      telescope.load_extension("fzf")
    end
  }
}
