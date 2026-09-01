local M = {}

function M.lualine()
  local theme = require("lualine.themes.catppuccin")

  for _, mode in pairs(theme) do
    mode.a.fg = mode.a.bg
    mode.a.gui = ""

    for _, section in pairs(mode) do
      section.bg = nil
    end
  end

  return {
    theme = theme,
    components = {},
    extensions = {
      active = "#f38ba8",        -- catppuccin mocha red
      inactive = "#45475a",      -- catppuccin mocha surface1
      inactive_recent = "#6c7086", -- catppuccin mocha overlay0
    },
  }
end

return M
