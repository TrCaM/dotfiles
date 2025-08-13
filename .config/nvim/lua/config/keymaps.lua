-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })

-- Move Lines
vim.api.nvim_set_keymap("n", "<A-j>", "", { desc = "Disable Move down" })
vim.api.nvim_set_keymap("n", "<A-k>", "", { desc = "Disable Move up" })
vim.api.nvim_set_keymap("i", "<A-j>", "", { desc = "Disable Move down" })
vim.api.nvim_set_keymap("i", "<A-k>", "", { desc = "Disable Move up" })
vim.api.nvim_set_keymap("v", "<A-j>", "", { desc = "Disable Move down" })
vim.api.nvim_set_keymap("v", "<A-k>", "", { desc = "Disable Move up" })

-- Move Lines
vim.api.nvim_set_keymap("n", "[<space>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.api.nvim_set_keymap("n", "]<space>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.api.nvim_set_keymap("v", "[<space>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.api.nvim_set_keymap("v", "]<space>", "<cmd>m .+1<cr>==", { desc = "Move down" })

vim.api.nvim_set_keymap("t", "jj", [[<C-\><C-n>]], { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "jj", "<ESC>", { silent = true, noremap = true })
------------------------------

-- New command to Set AutoCompletion on and off -
-- local cmp = require("cmp")
--
-- function SetAutoCmp(mode)
--   if mode then
--     cmp.setup({
--       completion = {
--         autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
--       },
--     })
--   else
--     cmp.setup({
--       completion = {
--         autocomplete = false,
--       },
--     })
--   end
-- end
-- SetAutoCmp(false)
--
-- -- enable automatic completion popup on typing
-- vim.cmd("command AutoCmpOn lua SetAutoCmp(true)")
--
-- -- disable automatic competion popup on typing
-- vim.cmd("command AutoCmpOff lua SetAutoCmp(false)")
--
-- vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>AutoCmpOn<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>A", "<cmd>AutoCmpOff<cr>", { noremap = true, silent = true })
------------------------------

local wk = require("which-key")
wk.add({
  {
    "<leader>p",
    group = "+Paths",
  },
  { "<leader>pp", "<cmd>lua require('util.pathcopy').copy_full_path()<cr>", desc = "Copy Full Path" },
  { "<leader>pr", "<cmd>lua require('util.pathcopy').copy_relative_path()<cr>", desc = "Copy Relative Path" },
  { "<leader>pf", "<cmd>lua require('util.pathcopy').copy_filename()<cr>", desc = "Copy Filename" },
  { "<leader>pg", "<cmd>lua require('util.pathcopy').copy_google3_tail()<cr>", desc = "Copy google3 Path" },
})
