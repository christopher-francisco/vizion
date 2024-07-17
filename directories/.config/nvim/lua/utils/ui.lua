local M = {}

function M.statuscolumn()
  local components = { "", "", "" }

  if vim.v.virtnum == 0 then
    if vim.v.relnum == 0 then
      components[1] = "%l"  -- the current line
    else
      components[1] = "%r" -- other lines
    end

    components[1] = "%= " .. components[1] .. " "
  else
    components[1] = "%= "
  end

  return table.concat(components, "")
end

return M
