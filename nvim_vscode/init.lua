local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- open config
vim.cmd('nmap <leader>c :e C:/Users/user/AppData/Local/nvim/init.lua<cr>')

-- skip folds
vim.cmd('nmap j gj')
vim.cmd('nmap k gk')
vim.cmd('vmap j gj')
vim.cmd('vmap k gk')

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 500

-- sync system clipboard
vim.opt.clipboard = 'unnamedplus' 

-- search ignoring case
vim.opt.ignorecase = true

-- disable swapfiles
vim.opt.swapfile = false

-- clear search highlighting
-- vim.keymap.set('n', '<tab>', ':nohlsearch<cr>')
vim.opt.hlsearch = false

-- disable "ignorecase" option if the search pattern contains upper case characters
vim.opt.smartcase = true

-- switch between left and right editor
vim.keymap.set('n', '<leader>h', function()
  vim.fn.VSCodeCall('workbench.action.focusLeftGroup')
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>l', function()
  vim.fn.VSCodeCall('workbench.action.focusRightGroup')
end, { noremap = true, silent = true })

-- close active editor
vim.keymap.set('n', '<leader>w', function()
  vim.fn.VSCodeCall('workbench.action.closeActiveEditor')
end, { noremap = true, silent = true })

-- ctrl+p
-- vim.keymap.set('n', '<leader>p', function()
--   vim.fn.VSCodeCall('workbench.action.quickOpen')
-- end, { noremap = true, silent = true })

-- ctrl+shift+o
vim.keymap.set('n', '<leader>o', function()
  vim.fn.VSCodeCall('workbench.action.gotoSymbol')
end, { noremap = true, silent = true })

-- ctrl+a
vim.keymap.set('n', '<leader>g', function()
  vim.fn.VSCodeCall('editor.action.selectAll')
end, { noremap = true, silent = true })

-- ]d
vim.keymap.set('n', ']d', function()
  vim.fn.VSCodeCall('editor.action.marker.nextInFiles')
end, { noremap = true, silent = true })

-- [d
vim.keymap.set('n', '[d', function()
  vim.fn.VSCodeCall("editor.action.marker.prevInFiles")
end, { noremap = true, silent = true })

-- [c
vim.keymap.set('n', '[c', function()
  vim.fn.VSCodeCall("workbench.action.editor.previousChange")
end, { noremap = true, silent = true })

-- ]c
vim.keymap.set('n', ']c', function()
  vim.fn.VSCodeCall("workbench.action.editor.nextChange")
end, { noremap = true, silent = true })

-- view show explorer
vim.keymap.set('n', '<leader>e', function()
  vim.fn.VSCodeCall("workbench.view.explorer")
end, { noremap = true, silent = true })

-- alt + up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- search centers the cursor
-- vim.keymap.set('n', 'n', "n zz", { noremap = true, silent = true})
-- vim.keymap.set('n', 'N', "N zz", { noremap = true, silent = true})

-- Toggle to the last editor in the current group
-- local lastEditor = nil
-- local currentEditor = nil
--
-- vim.keymap.set('n', '<leader><tab>', function()
--   -- get current editor index
--   local current = vim.fn.VSCodeCall('workbench.action.files.getActiveEditorIndex')
--
--   -- if lastEditor exists, switch to it
--   if lastEditor then
--     vim.fn.VSCodeCall('workbench.action.openEditorAtIndex', {index = lastEditor})
--     -- swap current and last for next toggle
--     currentEditor, lastEditor = lastEditor, current
--   else
--     -- first time, just store the current editor
--     lastEditor = current
--   end
-- end, { noremap = true, silent = true })

-- join while keeping the cursor at place
vim.keymap.set('n', 'J', "mzJ`z")

-- keep cursor at middle when jumping half page
vim.keymap.set('n', '<C-d>', "<C-d>zz", { noremap = true, silent = true})
vim.keymap.set('n', '<C-u>', "<C-u>zz", { noremap = true, silent = true})

-- preserve prev clip when pasting 
vim.keymap.set('x', '<leader>p', "\"_dP")

-- copy to system clipboard
-- vim.keymap.set('n', '<leader>y', '\"+y')
-- vim.keymap.set('v', '<leader>y', '\"+y')
-- vim.keymap.set('n', '<leader>Y', '\"+Y')

