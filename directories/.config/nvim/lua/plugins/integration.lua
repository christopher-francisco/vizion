return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate left, pane or split" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate down, pane or split"  },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate up, pane or split"  },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate right, pane or split"  },
    },
  },
}
