---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "prettierd" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              codeLens = { enable = true },
              completion = { callSnippet = "Replace" },
              hint = { enable = true, setType = false, paramType = true },
            },
          },
        },
        cssls = {},
        cssmodules_ls = {},
      },
    },
  },
}
