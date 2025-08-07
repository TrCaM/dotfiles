-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("customed_" .. name, { clear = true })
end

-- -- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("color_column_80"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "80"
  end,
})

-- Temporary disable python diagnostic for leetcode
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("python_leetcode"),
  pattern = { "python" },
  callback = function()
    vim.opt_local.textwidth = 80
    -- vim.diagnostic.config({ underline = false, virtual_text = false, signs = false }, 47)
    -- vim.diagnostic.config({ underline = false, virtual_text = false, signs = false }, 48)
    vim.diagnostic.enable(false)
  end,
})

-- Create a ruler at column 100
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("color_column_100"),
  pattern = { "lua" },
  callback = function()
    vim.opt_local.textwidth = 100
    vim.opt_local.colorcolumn = "100"
  end,
})
