return {
  {
    "folke/which-key.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 700
    end,
    opts = {
    }
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard" } },
          component_separators = '',
        },
        sections = {
          lualine_a = {
            { "mode", icon = { "" } }
          },
          lualine_b = {
            { "branch", icon = { ""  } }
          },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 0, symbols = { modified = "", readonly = "" }, padding = { left = 0 } },
          },
          lualine_x = {
            { "diff", symbols = {added = ' ', modified = ' ', removed = ' '} }
          },
          lualine_y = {
            { "selectioncount" },
            { "diagnostics" },
          },
          lualine_z = {
            { "location" }
          },
        },
        tabline = {
          lualine_a = {
            {
              "tabs",
              mode = 1,
              path = 0,
              show_modified_status = true,
              symbols = {
                modified = '',
              },
            }
          }
        },
        extensions = {
          "quickfix",
          "neo-tree",
          "lazy",
          "oil",
          "trouble",
        },
      }

      return opts
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = function()
      local art = require('utils.art').vizion_shadow

      -- Add some margin
      local logo = string.rep("\n", art.margin_top) .. art.text .. string.rep("\n", art.margin_bottom)

      local opts = {
        theme = "doom",
        hide = {
          statusline = false, -- taken from LazyVim, some sort of conflict happens otherwise
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = ":so ~/.local/state/nvim/session.vim", desc = " Restore session", icon = "󰦛 ", key = "s", },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r", },
            { action = "Telescope git_files", desc = " Find file", icon = " ", key = "f" },
            { action = "Telescope find_files", desc = " Search file", icon = "󰥨 ", key = "F" },
            -- { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
            { action = "Telescope live_grep", desc = " Search text", icon = " ", key = "g" },
            { action = "Telescope find_files cwd=~/.config/nvim", desc = " Config files", icon = "󰒓 ", key = "c" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "e ~/.tmux.conf", desc = " Tmux config", icon = " ", key = "t" },
            { action = "Telescope find_files cwd=~/.tmux", desc = " Tmux config (Dir)", icon = " ", key = "T" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    -- keys = {
    --   {
    --     "<leader>xx",
    --     "<cmd>Trouble diagnostics toggle<cr>",
    --     desc = "Diagnostics (Trouble)",
    --   },
    --   {
    --     "<leader>xX",
    --     "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    --     desc = "Buffer Diagnostics (Trouble)",
    --   },
    --   {
    --     "<leader>cs",
    --     "<cmd>Trouble symbols toggle focus=false<cr>",
    --     desc = "Symbols (Trouble)",
    --   },
    --   {
    --     "<leader>cl",
    --     "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    --     desc = "LSP Definitions / references / ... (Trouble)",
    --   },
    --   {
    --     "<leader>xL",
    --     "<cmd>Trouble loclist toggle<cr>",
    --     desc = "Location List (Trouble)",
    --   },
    --   {
    --     "<leader>xQ",
    --     "<cmd>Trouble qflist toggle<cr>",
    --     desc = "Quickfix List (Trouble)",
    --   },
    -- },
  }
}
