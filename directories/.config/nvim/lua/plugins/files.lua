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
    keys = {
      { "<leader>/", ":Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>:", ":Telescope command_history<cr>", desc = "Command history" },
      { "<leader>*", ":Telescope grep_string<cr>", desc = "Word" },
      { "<leader>ff", ":Telescope git_files<cr>", desc = "Find file" },
      { "<leader>fF", ":Telescope find_files<cr>", desc = "Find file (all)" },
      { "<leader>fr", ":Telescope oldfiles<cr>", desc = "Recent" },
      -- { "<leader>fR", ":Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fc", ":Telescope find_files cwd=~/.config/nvim<cr>", desc = "Find config file" },
      { "<leader>ftf", ":Telescope find_files cwd=~/.tmux<cr>", desc = "Find Tmux config file" },
      { "<leader>bl", ":Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>sm", ":Telescope marks<cr>", desc = "Marks" },
      { "<leader>sR", ":Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>uC",
        function()
          require('utils.colorscheme').load()
          require('telescope.builtin').colorscheme({ enable_preview = true, ignore_builtins = true })
        end,
        desc = "Colorschemes with preview"
      },
    },
    -- We don't use opts because we need a reference to actions and telescope for each individual option
    config = function()
      local telescope = require("telescope")
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
          },
          pickers = {
            find_files = {
              hidden = true
            },
            git_files = {
              hidden = true
            },
          },
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
  },
  {
    'stevearc/oil.nvim',
    opts = {
      skip_confirm_for_simple_edits = false,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<leader>|"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<leader>-"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        -- Avoid conflict with window movement
        ["<leader>l"] = "actions.refresh",
      }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  }
}
