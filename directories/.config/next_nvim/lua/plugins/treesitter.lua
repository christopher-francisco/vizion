return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    branch = "main",
    build = ":TSUpdate",
    event = "FileLoad",
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@comment.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@comment.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@comment.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@comment.outer",
          },
        },
      },
      ensure_installed = {
        "bash",
        "blade",
        "c_sharp",
        "css",
        "diff",
        "dockerfile",
        "gitcommit",
        "gitignore",
        "graphql",
        "hcl",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "kotlin",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "php",
        "prisma",
        "query",
        "regex",
        "scss",
        "swift",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Shows current function/class context pinned at the top while scrolling
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "FileLoad",
    opts = {
      max_lines = 3,
    },
    keys = {
      { "[x", function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = "Jump to context" },
    },
  },
}
