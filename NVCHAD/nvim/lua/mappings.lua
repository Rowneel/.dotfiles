require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

----------------------------------
-- Overriding Nvimtree mappings --
----------------------------------
-- removing the previous maps
vim.keymap.del("n", "<leader>pt")
-- vim.keymap.del("n", "<leader>e")
-- overriding the previous maps
-- map("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggel" })
map("n", "<leader>p", "<Cmd>Telescope find_files<CR>", { desc = "telescope find files" })
map("n", "<leader>tt", "<Cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

-- Auto-import and organize imports
map("n", "<leader>ai", function()
  vim.lsp.buf.code_action {
    context = { only = { "source.addMissingImports.ts" } },
    apply = true,
  }
end, { desc = "Auto-import under cursor" })

--Organize the imports
map("n", "<leader>oi", function()
  vim.lsp.buf.code_action {
    context = { only = { "source.organizeImports.ts" } },
    apply = true,
  }
end, { desc = "Organize imports" })

--Organize unused imports
map("n", "<leader>ou", function()
  vim.lsp.buf.code_action {
    context = { only = { "source.removeUnused.ts" } },
    apply = true,
  }
end, { desc = "Remove Unused Imports" })

-- Show diagnostic float with close
map("n", "<leader>i", function()
  local float_buf, float_win = vim.diagnostic.open_float(nil, { focusable = true })
  if float_win then
    vim.api.nvim_buf_set_keymap(float_buf, "n", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
  end
end, { desc = "LSP: Show diagnostic with close on ESC" })

--Select all
map("n", "<leader>sa", "ggVG", { desc = "Select all" })

-- telescope diagnostic
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope diagnostics" })

-- quickfix navigation
map("n", "<M-j>", "<cmd>cnext<CR>zz", { desc = "Quickfix Next" })
map("n", "<M-k>", "<cmd>cprev<CR>zz", { desc = "Quickfix Prev" })

-- Optional: Enhance <leader>ca with Telescope
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Code actions" })

-- get keycode
map("n", "<leader>kc", function()
  local k = vim.fn.getchar()
  local output = tostring(k)
  vim.api.nvim_put({ output }, "c", true, true)
end, { desc = "Insert keycode at cursor" })

-- Easy switch between alternate files
map("n", "<leader><leader>", ":b#<CR>", { desc = "Switch to alternate file" })

-- put references to quickfix
map("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", { desc = "LSP Go to references" })

-- map :q to alt+q
map("n", "<M-q>", "<Cmd>q<CR>", { desc = "Quit buffer" })

--------------------------
-- centers after search --
--------------------------
-- Map n (next match) to center the cursor as well
map("n", "n", "nzz", { desc = "Next search result and center cursor" })
-- Map N (previous match) to center the cursor as well
map("n", "N", "Nzz", { desc = "Previous search result and center cursor" })

-----------------------
-- Gitsigns keybinds --
-----------------------
-- Toggle Gitsigns inline blame
map("n", "<leader>gb", "<Cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Gitsigns Toggle Current Line Blame" })
map("n", "<leader>gd", "<Cmd>Gitsigns toggle_deleted<CR>", { desc = "Gitsigns Toggle Deleted" })
map("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", { desc = "Gitsigns preview_hunk" })
map("n", "]c", "<Cmd>Gitsigns prev_hunk<CR>", { desc = "Gitsigns Previous Hunk" })
map("n", "[c", "<Cmd>Gitsigns next_hunk<CR>", { desc = "Gitsigns Next Hunk" })

-- Uncomment if desired
-- map("n", ";", ":", { desc = "Enter command mode" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-------------------
-- Custom Macros --
-------------------

-- console log selected item
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.fn.setreg("l", "oconsole.log('" .. esc .. "pa:', " .. esc .. "pa)" .. esc .. "A;" .. esc .. "dd", "n")
vim.fn.setreg("k", "oprint('" .. esc .. "pa:', " .. esc .. "pa)" .. esc .. "A" .. esc .. "dd", "n")
