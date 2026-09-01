local M = {}

function M.lualine()
  local theme = require("lualine.themes.cyberdream")

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
      active = "#ff6e5e",        -- cyberdream red/accent
      inactive = "#1e2a2f",      -- cyberdream dark bg
      inactive_recent = "#3d4e58", -- cyberdream overlay
    },
  }
end

return M
