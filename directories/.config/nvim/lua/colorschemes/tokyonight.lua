local M = {}

function M.lualine()
  local theme = require('lualine.themes.tokyonight-night')

  for _, mode in pairs(theme) do
    mode.a.fg = mode.a.bg
    mode.a.gui = ""

    -- mode.c.fg = mode.b.fg

    for _, section in pairs (mode) do
      section.bg = nil
    end
  end

  local components = {
    -- location = { fg = colours.grey2 }
  }

  return {
    theme = theme,
    components = components,
    extensions = {
      active = '#f7768e',
      inactive = "#3b4261",
      inactive_recent = "#a9b1d6",
    }
  }
end

return M

