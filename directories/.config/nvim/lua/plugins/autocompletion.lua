return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",

      -- FIXME: lacking a setup function to set the square width
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },

      --[[
      'petertriho/cmp-git',
      'roginfarrer/cmp-css-variables',
      ]]--
    },

    opts = function()
      local cmp = require("cmp")

      return {
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },

          -- Note: added this here as otherwise the snippets are loaded before lsp results
          { name = 'luasnip' },

          { name = 'path' },

          -- { name = 'css-variables' }

        }, {
          { name = 'buffer' },
        }),
        formatting = {
          format = require("tailwindcss-colorizer-cmp").formatter
        }
      }
    end,

    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      --[[
      -- requires `petertriho/cmp-git`

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      })
      require("cmp_git").setup()

      -- requires require cmp-cmdline
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { 
          disallow_symbol_nonprefix_matching = false,
        }
      })

      -- requires "roginfarrer/cmp-css-variables"
      -- needs to setup `vim.g.css_variables_files = { "variables.css" }`
      ]]--
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {
      enable = true
    },
  }
}
