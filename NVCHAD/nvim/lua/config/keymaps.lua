-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local unmap = vim.keymap.del

map("i", "jj", "<Esc>", { noremap = false })
map("n", "<leader>z", "ggVG", { desc = "Select all" })
map("n", "<leader>k", ":b#<CR>", { desc = "Switch to alternate file" })
