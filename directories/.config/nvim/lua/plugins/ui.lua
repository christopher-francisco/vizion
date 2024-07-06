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
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    opts = function()
      local logo = [[
         ███████  ███   ███  ████████   ███  ████████
        ███       ███   ███  ███   ███  ███  ███     
        ███       █████████  ████████   ███  ████████
        ███       ███   ███  ███   ███  ███       ███
         ███████  ███   ███  ███   ███  ███  ████████
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local builtin = require("telescope.builtin")

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            {
              action = function()
                builtin.git_files()
              end,
              desc = " Find File",
              icon = "",
              key = "f"
            },
            { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
            {
              action = function ()
                builtin.oldfiles()
              end,
              desc = " Recent Files",
              icon = " ",
              key = "r",
            },
            --{ action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
            --{ action = [[lua LazyVim.telescope.config_files()()]], desc = " Config", icon = " ", key = "c" },
            --{ action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
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
