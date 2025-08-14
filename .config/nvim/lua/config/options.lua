-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local global = vim.g
local api = vim.api

opt.wrap = true
opt.clipboard = ""
opt.cursorline = true

global.maplocalleader = "\\"
global.vim_markdown_frontmatter = 1
vim.cmd("highlight Folded ctermbg=NONE guibg=NONE")

-- Set cursorline to be dimmer and transparent
api.nvim_set_hl(0, "CursorLine", {
  bg = "NONE",
  blend = 20,
  -- Use a very subtle background color that works with most themes
  ctermbg = "NONE",
})

-- Alternative approach using autocmd for theme compatibility
api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    api.nvim_set_hl(0, "CursorLine", {
      bg = "#1a1a1a",
      blend = 30,
      ctermbg = "NONE",
    })
  end,
})
