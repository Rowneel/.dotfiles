return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    -- opts = require "configs.conform",
    config = function()
      require "configs.conform"
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format { bufnr = args.buf }
        end,
      })
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        -- keep default nvim-tree keymaps
        require("nvim-tree.api").config.mappings.default_on_attach(bufnr)

        -- helper to copy path with forward slashes
        local function copy_with_slash(fn)
          return function()
            fn()
            local reg = vim.fn.getreg "+"
            vim.fn.setreg("+", reg:gsub("\\", "/"))
            vim.notify("Copied: " .. vim.fn.getreg "+")
          end
        end

        local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

        -- override yp / yP to copy with forward slashes
        vim.keymap.set("n", "yp", copy_with_slash(api.fs.copy.absolute_path), opts)
        vim.keymap.set("n", "yP", copy_with_slash(api.fs.copy.relative_path), opts)
      end,
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = { "smart" }, -- Intelligently shorten paths for Windows
        git_timeout = 2000,
        mappings = {
          i = { -- Insert mode mappings
            ["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
          },
          n = { -- Normal mode mappings
            ["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
          },
        },
      },
    },
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" },
    },
  },

  -- Gitsigns
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   config = function()
  --     require("gitsigns").setup {
  --       timeout = 2000, -- 2 seconds
  --     }
  --   end,
  -- },

  -- {
  --   "mbbill/undotree",
  --   lazy = false,
  --   config = function()
  --     -- vim.g.undotree_WindowLayout = 2
  --     require("undotree").setup {}
  --     vim.g.undotree_SplitWidth = 28
  --     vim.g.undotree_DiffCommand = "FC"
  --     vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
  --   end,
  -- },

  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
      -- Git diffget: use current or incoming changes during merge conflict
      vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", { desc = "Get current change (ours)" })
      vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", { desc = "Get incoming change (theirs)" })
      -- Toggle git status with Fugitive
      vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status (Fugitive)" })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "eslint-lsp", -- Optional, for future use
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "ts_ls", "html", "cssls", "eslint" },
      automatic_installation = true,
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            on_attach = require("nvchad.configs.lspconfig").on_attach,
            on_init = require("nvchad.configs.lspconfig").on_init,
            capabilities = require("nvchad.configs.lspconfig").capabilities,
          }
        end,
      },
    },
  },

  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   config = function()
  --     require("ts_context_commentstring").setup {
  --       enable_autocmd = false,
  --     }
  --   end,
  -- },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "vim", "lua" },
          highlight = {
            enable = true,
          },
        }
      end,
    },
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup {
          pre_hook = function()
            return vim.bo.commentstring
          end,
        }
      end,
    },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    -- build = "make",
    build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    config = function()
      require "configs.avante"
    end,
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "tsx",
        "javascript",
      },
      highlight = { enable = true },
      indent = { enable = true },
      -- autotag = { enable = true }, -- For nvim-ts-autotag
    },
  },
}
