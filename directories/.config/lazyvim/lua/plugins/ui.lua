---@type LazySpec
return {
  -- Disable bufferline — using native tabs via lualine tabline
  { "akinsho/bufferline.nvim", enabled = false },

  -- Tokyonight: night style (plugin already included by LazyVim)
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
  },

  -- Additional colorschemes
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "neanias/everforest-nvim", lazy = true, opts = { background = "soft", italics = true } },

  -- Dashboard: custom Vizion logo via snacks.nvim
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = string.rep("\n", 2)
            .. [[
████═╗      ████═╗████═╗██████████████═╗████═╗  ████████████═╗  ██████═╗      ████═╗
████ ║      ████ ║████ ║ ╚════██████ ╔═╝████ ║████ ╔══════████═╗████████═╗    ████ ║
████ ║      ████ ║████ ║    ██████ ╔═╝  ████ ║████ ║      ████ ║████ ╔████═╗  ████ ║
 ╚████═╗  ████ ╔═╝████ ║  ██████ ╔═╝    ████ ║████ ║      ████ ║████ ║ ╚████═╗████ ║
   ╚████████ ╔═╝  ████ ║██████████████═╗████ ║ ╚████████████ ╔═╝████ ║   ╚████████ ║
     ╚═══════╝     ╚═══╝ ╚═════════════╝ ╚═══╝   ╚═══════════╝   ╚═══╝     ╚═══════╝]]
            .. "\n",
          keys = {
            { icon = "󰦛 ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = " ", key = "f", desc = "Find File (git)", action = ":lua Snacks.picker.git_files()" },
            { icon = "󰥨 ", key = "F", desc = "Find File (all)", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "g", desc = "Live Grep", action = ":lua Snacks.picker.grep()" },
            { icon = "󰒓 ", key = "c", desc = "Config Files", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },

  -- Lualine: restore custom sections
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_extend("force", opts.options or {}, {
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard" } },
      })
      opts.sections = {
        lualine_a = {
          { "mode", icon = { "" } },
          { "branch", icon = { "" }, padding = { right = 2, left = 2 } },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 0, symbols = { modified = "", readonly = "" }, padding = { left = 0 } },
        },
        lualine_b = {},
        lualine_c = {
          "%=",
          {
            function() return require("tmux-status").tmux_windows() end,
            cond = function() return require("tmux-status").show() end,
            padding = { left = 2 },
          },
        },
        lualine_x = {
          {
            function() return "󱑍 " .. os.date("%X") end,
            cond = function() return os.getenv("TMUX") == nil end,
          },
        },
        lualine_y = {
          { "selectioncount" },
          { "diagnostics" },
          { "progress", padding = { left = 2, right = 1 } },
          { "location", padding = { right = 1 } },
        },
        lualine_z = {
          {
            function() return require("tmux-status").tmux_battery() end,
            cond = function() return require("tmux-status").show() end,
            padding = { left = 1, right = 1 },
          },
          {
            function() return require("tmux-status").tmux_datetime() end,
            cond = function() return require("tmux-status").show() end,
            padding = { left = 1, right = 1 },
          },
          {
            function() return require("tmux-status").tmux_session() end,
            cond = function() return require("tmux-status").show() end,
            padding = { left = 1, right = 1 },
          },
        },
      }
      opts.tabline = {
        lualine_a = {
          {
            "tabs",
            mode = 1,
            path = 0,
            show_modified_status = true,
            max_length = vim.o.columns,
            symbols = { modified = "" },
          },
        },
      }
      opts.extensions = { "quickfix", "lazy", "oil", "trouble" }
      return opts
    end,
  },

  -- which-key: custom groups
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>w", group = "write" },
        { "<leader>b", group = "buffers" },
        { "<leader>S", group = "session" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>gb", group = "buffer" },
        { "<leader>gl", group = "line" },
        { "<leader>ft", group = "tmux/config" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>_", group = "open in split" },
        { "<leader>|", group = "open in vsplit" },
        { "[", group = "prev" },
        { "]", group = "next" },
      },
    },
  },
}
