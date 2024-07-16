vim.api.nvim_create_user_command(
  'CEdit',
  function(details)
    local args = details.fargs

    vim.cmd('vsp')
    vim.cmd('e ~/.config/nvim/lua/chris/' .. args[1] .. '.lua')
  end,
  { nargs = 1 }
)
