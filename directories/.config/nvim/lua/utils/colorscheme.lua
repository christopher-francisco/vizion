local M = {}

M.colorscheme = 'tokyonight'

local pattern = "ColorSchemeLoad"

-- Register autocmds
function M.register()
  vim.api.nvim_create_autocmd("User", {
    pattern = pattern,
    desc = "Load all colorschemes",
    once = true,
    callback = function()
      print('Colorschemes loaded')
    end
  })
end

--- @param name string
--- @return boolean
function M.should_lazy_load(name)
  return name ~= M.colorscheme
end

--- @param name string
--- @return number
function M.get_priority(name)
  return name ~= M.colorscheme and 50 or 1000
end

--- @param name string
--- @return string
function M.get_event(name)
  return name == M.colorscheme and nil or "User " .. pattern
end

function M.load()
  vim.api.nvim_exec_autocmds("User", { pattern = pattern })
end

return M
