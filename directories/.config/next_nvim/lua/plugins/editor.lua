return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "echasnovski/mini.icons",
      { "MunifTanjim/nui.nvim", lazy = true },
    },
    cmd = "Neotree",
    keys = {
      { "<leader>E", ":Neotree toggle reveal dir=./product-areas/document-management<cr>", desc = "Open file explorer" },
      { "<leader>e", ":Neotree toggle reveal dir=./<cr>", desc = "Open file explorer relative" },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
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
    end,
    opts = {
      window = {
        position = "right",
        auto_expand_width = true,
      },
      filesystem = {
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        bind_to_cwd = false,
      },
    },
  },

  -- Directory editor
  {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    cmd = "Oil",
    keys = {
      { "-", ":Oil<cr>", desc = "Open Oil" },
      { "<leader>_o", ":sp|Oil<cr>", desc = "Open split, then Oil" },
      { "<leader>|o", ":vsp|Oil<cr>", desc = "Open vertical split, then Oil" },
      { "<leader><tab>o", ":tabnew|Oil<cr>", desc = "New Tab, then Oil" },
    },
    opts = {
      skip_confirm_for_simple_edits = false,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-s>"] = false,
        ["<leader>|"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-h>"] = false,
        ["<leader>-"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<leader>l"] = "actions.refresh",
        ["<C-l>"] = false,
      },
    },
  },

  -- Motion / jump
  {
    "folke/flash.nvim",
    event = "FileLoad",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Git signs and hunk operations
  {
    "lewis6991/gitsigns.nvim",
    event = "FileLoad",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", function()
          if vim.wo.diff then vim.cmd.normal({ "]c", bang = true })
          else gs.nav_hunk("next") end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then vim.cmd.normal({ "[c", bang = true })
          else gs.nav_hunk("prev") end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>gbs", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gbr", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gbb", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>glb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- Tmux pane navigation
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate left, pane or split" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate down, pane or split" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate up, pane or split" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate right, pane or split" },
    },
  },

  -- Tmux status in lualine
  {
    "christopher-francisco/tmux-status.nvim",
    lazy = true,
    opts = function()
      local colorscheme = require("utils.colorscheme").colorscheme
      local custom = require("colorschemes." .. colorscheme).lualine()
      return {
        colors = {
          window_active = custom.extensions.active,
          window_inactive = custom.extensions.inactive,
          window_inactive_recent = custom.extensions.inactive_recent,
        },
      }
    end,
  },

  -- TODO/FIXME/HACK/NOTE highlighting
  {
    "folke/todo-comments.nvim",
    event = "FileLoad",
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev Todo Comment" },
      { "<leader>st", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>sT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
  },

  -- Multi-file find and replace
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          require("grug-far").open({
            transient = true,
            prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
          })
        end,
        desc = "Search and Replace",
        mode = { "n", "v" },
      },
    },
    opts = { headerMaxWidth = 80 },
  },

  -- Laravel framework integration (depends on nui, not telescope)
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
      "kevinhwang91/promise-async",
    },
    cmd = { "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>" },
      { "<leader>lr", ":Laravel routes<cr>" },
      { "<leader>lm", ":Laravel related<cr>" },
    },
    event = { "FileLoad" },
    opts = {},
    config = true,
  },
}
