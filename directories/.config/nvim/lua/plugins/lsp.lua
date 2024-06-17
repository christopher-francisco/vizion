return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      -- FIXME: should cmp-nvim-lsp be declared here?
      { "folke/neodev.nvim", opts = {} },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },

        tsserver = {},

        tailwindcss = {},

        terraformls = {},

        csharp_ls = {},
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      for severity, icon in pairs(opts.diagnostics.signs.text) do
        local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))


      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('chris.keymaps').on_attach(client, buffer)
        end,
      })

      for server, server_opts in pairs(servers) do
        local merged_server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, server_opts)

        require("lspconfig")[server].setup(merged_server_opts)
      end
    end,
  }
}
