vim.api.nvim_create_user_command(
  'CEdit',
  function()
    vim.cmd('vsp')
    vim.cmd('e ~/.config/nvim/lua/chris')
  end,
  {}
)
