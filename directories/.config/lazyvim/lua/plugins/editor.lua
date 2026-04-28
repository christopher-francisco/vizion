---@type LazySpec
return {
  -- Oil.nvim — edit the filesystem like a buffer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    lazy = false,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Oil" },
      { "<leader>_o", "<cmd>sp|Oil<cr>", desc = "Oil in Split" },
      { "<leader>|o", "<cmd>vsp|Oil<cr>", desc = "Oil in Vertical Split" },
    },
    opts = {
      skip_confirm_for_simple_edits = false,
      view_options = { show_hidden = true },
    },
  },

  -- Gitsigns: restore custom keymaps (diff-aware hunk navigation)
  {
    "lewis6991/gitsigns.nvim",
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
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function()
          gs.nav_hunk("last")
        end, "Last Hunk")
        map("n", "[H", function()
          gs.nav_hunk("first")
        end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>gbs", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gbr", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gbb", function()
          gs.blame()
        end, "Blame Buffer")
        map("n", "<leader>glb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- Snacks: custom picker keymaps not covered by the snacks_picker extra
  {
    "snacks.nvim",
    keys = {
      {
        "<leader>bl",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>ftf",
        function()
          Snacks.picker.files({ cwd = "~/.config/tmux" })
        end,
        desc = "Tmux Config Files",
      },
    },
    opts = {
      indent = {
        enabled = false,
      },
    },
  },

  -- Delete persistence.nvim's <leader>qs (Restore Session) — using <leader>SL instead
  {
    "folke/persistence.nvim",
    keys = {
      { "<leader>qs", false },
    },
  },
}
