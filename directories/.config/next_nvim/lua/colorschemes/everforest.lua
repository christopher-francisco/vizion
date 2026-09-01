local M = {}

function M.lualine()
  local colours = require('everforest.colours').generate_palette(
    vim.tbl_extend("force", require('everforest').config, {
      -- TODO: get these from lazy colorscheme opt instead
      background = "soft",
      italics = true,
    }),
    "dark"
  )

  local theme = require('lualine.themes.everforest')

  for _, mode in pairs(theme) do
    mode.a.fg = mode.a.bg
    mode.a.gui = ""

    mode.c.fg = mode.b.fg

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
      active = '#e69875',
      inactive = "#a9b1d6", -- FIXME: broken
      inactive_recent = "#3b4261", -- FIXME: broken
    }
  }
end

return M
