return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    {
      "nvim-cmp",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
      },
      opts = function(_, opts)
        opts.snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        }
        -- NOTE: this line is making the snippet ordered before lsp results
        -- table.insert(opts.sources, { name = "luasnip" })
      end,
    },
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  keys = function()
    local luasnip = require("luasnip")
    return {
      {
        "<c-j>",
        function()
          luasnip.jump(1)
        end,
        silent = true,
        mode = "i",
      },
      {
        "<c-j>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s"
      },
      {
        "<c-k>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" }
      },
    }
  end,
}
