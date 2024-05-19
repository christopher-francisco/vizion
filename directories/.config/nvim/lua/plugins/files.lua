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
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "MunifTanjim/nui.nvim", lazy = true }, -- remove lazy true if not working
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, position = "right" })
        end,
        desc = "Open file explorer"
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, position = "right", reveal = true })
        end,
        desc = "Open file explorer relative"
      }
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- We use BufEnter instead of require because cwd is not yet set up properly
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end
  }
}
