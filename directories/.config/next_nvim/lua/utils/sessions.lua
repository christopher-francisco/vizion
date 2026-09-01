local M = {}

local base = "~/.local/state/nvim/sessions/"

---@class SessionOpts
---@field mode? "auto" | "user" defaults to "user"

---@param opts? SessionOpts 
---@return string
local function get_name(opts)
  opts = opts or {}
  local mode = opts.mode or "user"

  local current_dir = vim.fn.getcwd()
  local name = current_dir and current_dir:gsub("/", "_") or "default"

  return base .. name .. '-' .. mode .. '.vim'
end

---Save session for current working directory
---@param opts? SessionOpts 
function M.save(opts)
  vim.fn.mkdir(vim.fn.expand(base), "p")
  vim.cmd('mks! ' .. get_name(opts))
end

---Load session for current working directory
---@param opts? SessionOpts 
function M.load(opts)
  local session_file = get_name(opts)

  if not vim.fn.filereadable(session_file) then
    print(" No saved session")
    return
  end

  local status, error = pcall(vim.cmd, 'silent so ' .. session_file)

  if not status then
    print(" Unable to load session, it may be corrupted. Call `:ClearSession` or `:ClearSessionAll`")
  end
end

---Register autocmd for auto-sessions and manual commands for clearning them
function M.register()
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("session-save", { clear = true }),
    callback = function()
      M.save({ mode = "auto" })
    end,
  })

  vim.api.nvim_create_user_command("SessionClear", function ()
    local error_auto = vim.fn.delete(vim.fn.expand(get_name({ mode = "auto" })))
    local error_user = vim.fn.delete(vim.fn.expand(get_name()))

    if error_auto or error_user then
      print("Unable to clear session")
    end
  end, {})

  vim.api.nvim_create_user_command("SessionClearAll", function ()
    local error = vim.fn.delete(vim.fn.expand(base), "rf")
    if error then
      print("Unable to clear all sessions")
    end
  end, {})
end

return M
