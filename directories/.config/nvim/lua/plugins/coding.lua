return {
  {
    'echasnovski/mini.ai',
    version = false,
    event = "FileLoad",
    opts = function ()
      local ai = require('mini.ai')
      return {
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          c = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
          F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        }
      }
    end
  },
  {
    "echasnovski/mini.surround",
    keys = {
      { "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
      { "gsd", desc = "Delete Surrounding" },
      { "gsf", desc = "Find Right Surrounding" },
      { "gsF", desc = "Find Left Surrounding" },
      { "gsh", desc = "Highlight Surrounding" },
      { "gsr", desc = "Replace Surrounding" },
      { "gsn", desc = "Update `MiniSurround.config.n_lines`" },
    },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      {  "gS", "<cmd>TSJSplit<cr>", desc = "Split node" },
      {  "gJ", "<cmd>TSJJoin<cr>", desc = "Join node" },
    },
    opts = {
      use_default_keymaps = false,
    },
    config = function(_, opts)
      require('treesj').setup(opts)
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {                                        -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
    ft = { "markdown" },
    opts = {}
  },
  {
    "windwp/nvim-ts-autotag",
    event = "FileLoad",
    opts = {
      enable = true
    },
  },

  {
    "echasnovski/mini.pairs",
    event = "FileLoad",
    opts = {
      modes = { insert = true, command = false, terminal = false },

      -- skip autopair when next character is one of these
      -- skip_next = [=[[%w%%%'%[%"%.%`%$]]=],

      -- skip autopair when the cursor is inside these treesitter nodes
      -- skip_ts = { "string" },

      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      -- skip_unbalanced = true,

      -- better deal with markdown code blocks
      markdown = true,
    },
  },
}
