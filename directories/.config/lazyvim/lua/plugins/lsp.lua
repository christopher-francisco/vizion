---@type LazySpec
return {
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
        -- ts_ls/vtsls + eslint handled by lang.typescript extra
        -- terraformls handled by lang.terraform extra
        -- jsonls + schemastore handled by lang.json extra
        -- yamlls handled by lang.yaml extra
        -- add as needed: csharp_ls, kotlin_language_server, phpactor, vacuum
      },
    },
  },
}
