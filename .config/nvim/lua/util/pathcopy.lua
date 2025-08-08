local M = {}

-- Helper: Set clipboard
local function copy_to_clipboard(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied to clipboard:\n" .. text)
end

-- Full path
function M.copy_full_path()
  local path = vim.fn.expand("%:p")
  copy_to_clipboard(path)
end

-- Relative path
function M.copy_relative_path()
  local path = vim.fn.expand("%:.")
  copy_to_clipboard(path)
end

-- Filename only
function M.copy_filename()
  local path = vim.fn.expand("%:t")
  copy_to_clipboard(path)
end

-- Special: Tail after google3/
function M.copy_google3_tail()
  local path = vim.fn.expand("%:p")
  local tail = path:match("google3/(.*)$")
  if tail then
    copy_to_clipboard(tail)
  else
    vim.notify("Path does not contain 'google3/'", vim.log.levels.WARN)
  end
end

return M
