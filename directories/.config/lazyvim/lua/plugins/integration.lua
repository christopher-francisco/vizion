---@type LazySpec
return {
  -- Tmux navigator — seamless pane/split navigation
  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate left" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate down" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate up" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate right" },
    },
    init = function() vim.g.tmux_navigator_disable_when_zoomed = 1 end,
  },

  -- Custom tmux status bar components (used by lualine in ui.lua)
  {
    "christopher-francisco/tmux-status.nvim",
    lazy = true,
    opts = {},
  },
}
