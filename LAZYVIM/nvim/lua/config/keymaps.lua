-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local unmap = vim.keymap.del

map("i", "jj", "<Esc>", { noremap = false })
map("n", "<leader>z", "ggVG", { desc = "Select all" })
map("n", "<leader>k", ":b#<CR>", { desc = "Switch to alternate file" })

---------------------
-- Logging keymaps --
---------------------
map("n", "<leader>cp", function()
  local ft = vim.bo.filetype
  local var = vim.fn.getreg('"')
  local log = ""

  if ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
    log = string.format('console.log("Logging %s", %s);', var, var)
  elseif ft == "python" then
    log = string.format('print("Logging %s", %s)', var, var)
  elseif ft == "lua" then
    log = string.format('print("Logging %s", %s)', var, var)
  elseif ft == "go" then
    log = string.format('fmt.Println("Logging %s", %s)', var, var)
  else
    log = string.format("-- No log format for %s", ft)
  end

  vim.api.nvim_put({ log }, "l", true, true)
end, { desc = "Insert language-specific log statement" })

-- Map n (next match) to center the cursor as well
map("n", "n", "nzz", { desc = "Next search result and center cursor" })
-- Map N (previous match) to center the cursor as well
map("n", "N", "Nzz", { desc = "Previous search result and center cursor" })

-- quickfix navigation
map("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Quickfix Next" })
map("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Quickfix Prev" })

-- LocList navigation
map("n", "<M-C-j>", "<cmd>lnext<CR>zz", { desc = "Quickfix Next" })
map("n", "<M-C-k>", "<cmd>lprev<CR>zz", { desc = "Quickfix Prev" })

-- keep cursor at middle when jumping half page
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
