---@type LazySpec
return {
  {
    "folke/which-key.nvim",
    event = "FileLoad",
    ---@class wk.Opts
    opts = {
      delay = 500,
      spec = {
        {
          mode = { "n" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>w", group = "write" },
          { "<leader>b", group = "buffers" },
          { "<leader>u", group = "ui" },
          { "<leader>S", group = "session" },
          { "<leader>g", group = "git" },
          { "<leader>s", group = "search" },
          { "[", group = "previous" },
          { "]", group = "next" },
          { "<leader>_", group = "Open in split" },
          { "<leader>|", group = "Open in vertical split" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function() require("which-key").show({ keys = "<c-w>", loop = true }) end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
  },

  {
    "echasnovski/mini.icons",
    lazy = true,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
      },
      filetype = {},
    },
  },

  -- Snacks: replaces dashboard-nvim, telescope, nvim-notify, indent-blankline,
  -- vim-illuminate, neoscroll, dressing.nvim, and adds lazygit + more
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = function()
      local art = require("utils.art").vizion_shadow
      local logo = string.rep("\n", art.margin_top) .. art.text .. string.rep("\n", art.margin_bottom)

      return {
        -- Start screen (replaces dashboard-nvim)
        dashboard = {
          enabled = true,
          sections = {
            {
              text = vim.split(logo, "\n"),
              align = "center",
              padding = 0,
            },
            { section = "keys", gap = 1, padding = 1 },
            { section = "startup" },
          },
          keys = {
            { key = "s", desc = "Restore session", icon = "󰦛 ", action = function() require("utils.sessions").load({ mode = "auto" }) end },
            { key = "S", desc = "Restore session (user)", icon = "󱄍 ", action = require("utils.sessions").load },
            { key = "r", desc = "Recent files", icon = " ", action = function() Snacks.picker.recent() end },
            { key = "f", desc = "Find file", icon = " ", action = function() Snacks.picker.git_files() end },
            { key = "F", desc = "Search file", icon = "󰥨 ", action = function() Snacks.picker.files() end },
            { key = "g", desc = "Search text", icon = " ", action = function() Snacks.picker.grep() end },
            { key = "c", desc = "Config files", icon = "󰒓 ", action = function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end },
            { key = "l", desc = "Lazy", icon = "󰒲 ", action = function() require("lazy").show() end },
            { key = "t", desc = "Tmux config", icon = " ", action = "e ~/.config/tmux/tmux.conf" },
            { key = "T", desc = "Tmux config (Dir)", icon = " ", action = function() Snacks.picker.files({ cwd = vim.fn.expand("~/.config/tmux") }) end },
            { key = "q", desc = "Quit", icon = " ", action = "qa" },
          },
        },

        -- Fuzzy finder (replaces telescope.nvim)
        picker = {
          enabled = true,
          sources = {
            colorschemes = { confirm = "colorscheme" },
          },
        },

        -- Floating notification UI (replaces nvim-notify default)
        notifier = {
          enabled = true,
          timeout = 3000,
        },

        -- Disable treesitter/LSP on large files
        bigfile = { enabled = true },

        -- Indent guides (replaces indent-blankline)
        indent = { enabled = true },

        -- Better vim.ui.input() float (replaces dressing.nvim)
        input = { enabled = true },

        -- Highlight word under cursor (replaces vim-illuminate)
        words = { enabled = true },

        -- Native smoothscroll (opt.smoothscroll = true) handles this; snacks.scroll disabled
        scroll = { enabled = false },

        -- Lazygit float
        lazygit = { enabled = true },

        -- Scope tracking
        scope = { enabled = true },

        -- Distraction-free mode
        zen = { enabled = true },

        -- Git blame line complement to gitsigns
        git = { enabled = true },
      }
    end,
    keys = {
      -- Picker keymaps (replaces telescope keymaps)
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
      { "<leader>*", function() Snacks.picker.grep_word() end, desc = "Word", mode = { "n", "v" } },
      { "<leader>ff", function() Snacks.picker.git_files() end, desc = "Find file" },
      { "<leader>fF", function() Snacks.picker.files() end, desc = "Find file (all)" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find config file" },
      { "<leader>ftf", function() Snacks.picker.files({ cwd = vim.fn.expand("~/.config/tmux") }) end, desc = "Find Tmux config file" },
      { "<leader>bl", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      {
        "<leader>uC",
        function()
          require("utils.colorscheme").load()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes with preview",
      },
      -- Git log pickers
      { "<leader>gL", function() Snacks.picker.git_log({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Git Log (file dir)" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git File History" },
      -- Lazygit
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      -- Zen mode
      { "<leader>uz", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      local colorscheme = require("utils.colorscheme").colorscheme
      local custom = require("colorschemes." .. colorscheme).lualine()
      local theme = custom.theme

      vim.cmd.highlight("custom_tab_active guifg=" .. custom.extensions.active)

      return {
        options = {
          component_separators = { left = " ", right = " " },
          section_separators = { left = " ", right = " " },
          theme = theme,
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "snacks_dashboard" } },
        },
        sections = {
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
              require("tmux-status").tmux_windows,
              cond = require("tmux-status").show,
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
              require("tmux-status").tmux_battery,
              cond = require("tmux-status").show,
              padding = { left = 1, right = 1 },
            },
            {
              require("tmux-status").tmux_datetime,
              cond = require("tmux-status").show,
              padding = { left = 1, right = 1 },
            },
            {
              require("tmux-status").tmux_session,
              cond = require("tmux-status").show,
              padding = { left = 1, right = 1 },
            },
          },
        },
        tabline = {
          lualine_a = {
            {
              "tabs",
              mode = 1,
              path = 0,
              show_modified_status = true,
              max_length = vim.o.columns,
              symbols = { modified = "" },
              tabs_color = { active = "custom_tab_active" },
            },
          },
        },
        extensions = {
          "quickfix",
          "neo-tree",
          "lazy",
          "oil",
          "trouble",
        },
      }
    end,
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Refs/Defs (Trouble)" },
    },
  },

  -- Optional: noice.nvim for polished cmdline/messages UI (disabled by default)
  -- Enable by removing `enabled = false`
  {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    ---@type NoiceConfig
    opts = {
      cmdline = {
        view = "cmdline",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        progress = { enabled = true },
      },
      routes = {
        {
          filter = { event = "msg_show", kind = "", find = "written" },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = false,
      },
    },
  },
}
