-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd

-- Filetype mappings
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { ".gitconfig*" },
  callback = function() vim.bo.filetype = "gitconfig" end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*tmux.conf*" },
  callback = function() vim.bo.filetype = "tmux" end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.mdc" },
  callback = function() vim.bo.filetype = "markdown" end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.query", "*.mutation" },
  callback = function() vim.bo.filetype = "graphql" end,
})

-- Add dbout to close-with-q filetypes (LazyVim already handles help, qf, trouble, etc.)
autocmd("FileType", {
  pattern = "dbout",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- EslintFixAll keymap on attach
autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "eslint" then
      vim.keymap.set("n", "<leader>cL", "<cmd>EslintFixAll<cr>", { buffer = args.buf, desc = "Fix Linting (ESLint)" })
    end
  end,
})

-- :CEdit <name> command — opens ~/.config/nvim/lua/chris/<name>.lua
vim.api.nvim_create_user_command("CEdit", function(args)
  vim.cmd("vsp ~/.config/nvim/lua/chris/" .. args.args .. ".lua")
end, { nargs = 1 })
