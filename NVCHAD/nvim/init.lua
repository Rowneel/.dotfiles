vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- context comment
-- local get_option = vim.filetype.get_option
-- vim.filetype.get_option = function(filetype, option)
--   return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
--     or get_option(filetype, option)
-- end

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.opt.nu = true
vim.opt.relativenumber = true
-- vim.opt.autochdir = true

-- For Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99 -- all folds open initially
vim.opt.foldlevelstart = 99

-- search ignoring case
vim.opt.ignorecase = true

-- disable swapfiles
vim.opt.swapfile = false

-- skip folds
-- vim.cmd('nnoremap j gj')
-- vim.cmd('nnoremap k gk')
-- vim.cmd('vnoremap j gj')
-- vim.cmd('vnoremap k gk')

-- clear search highlighting
vim.opt.hlsearch = false

vim.opt.scrolloff = 500

-- disable "ignorecase" option if the search pattern contains upper case characters
vim.opt.smartcase = true

-- alt + up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- change to normal mode in cmd
vim.keymap.set("t", "<leader><Esc>", "<C-\\><C-n>", { desc = "Exit terminal to normal mode" })

-- change to normal mode in cmd
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close window" })

-- join while keeping the cursor at place
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor at middle when jumping half page
-- vim.keymap.set("n", "<C-D>", "<C-D>zz")
-- vim.keymap.set("n", "<C-U>", "<C-U>zz")

-- preserve prev clip when pasting
vim.keymap.set("x", "<leader>p", '"_dP')

-- vscode

-- switch between left and right editor
-- vim.keymap.set('n', '<leader>h', function()
--   vim.fn.VSCodeCall('workbench.action.focusLeftGroup')
-- end, { noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>l', function()
--   vim.fn.VSCodeCall('workbench.action.focusRightGroup')
-- end, { noremap = true, silent = true })

-- close active editor
-- vim.keymap.set('n', '<leader>w', function()
--   vim.fn.VSCodeCall('workbench.action.closeActiveEditor')
-- end, { noremap = true, silent = true })

-- ctrl+p
-- vim.keymap.set('n', '<leader>p', function()
--   vim.fn.VSCodeCall('workbench.action.quickOpen')
-- end, { noremap = true, silent = true })

-- ctrl+shift+o
-- vim.keymap.set('n', '<leader>o', function()
--   vim.fn.VSCodeCall('workbench.action.gotoSymbol')
-- end, { noremap = true, silent = true })

-- ctrl+a
-- vim.keymap.set('n', '<leader>g', function()
--   vim.fn.VSCodeCall('editor.action.selectAll')
-- end, { noremap = true, silent = true })
