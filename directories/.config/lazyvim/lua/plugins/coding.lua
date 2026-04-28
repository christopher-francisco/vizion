---@type LazySpec
return {
  -- conform: prettierd for web filetypes
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
      },
    },
    -- <leader>cf is already provided by LazyVim via LazyVim.format()
  },

  -- LuaSnip: restore jump keymaps (friendly-snippets loaded by extra)
  {
    "L3MON4D3/LuaSnip",
    keys = {
      { "<c-j>", function() require("luasnip").jump(1) end, mode = { "i", "s" }, desc = "Next Snippet" },
      { "<c-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, desc = "Prev Snippet" },
    },
  },

  -- nvim-lint: no active linters (eslint handled by lang.typescript extra)
  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = {} },
  },
}
