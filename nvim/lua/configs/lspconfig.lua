require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "ts_ls", "eslint", "lua_ls", "tailwindcss" }
vim.lsp.enable(servers)

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "package.json", ".git"),
}

-- require("lspconfig").emmet_ls.setup {
--   filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.html.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascriptreact", "javascript.jsx" },
  capabilities = nvlsp.capabilities,
}

lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "python" },
}

------------------------------
-- Python Python-Lsp-Server --
------------------------------
-- lspconfig.pylsp.setup({
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   settings = {
--     pylsp = {
--       plugins = {
--         jedi = {
--           enabled = true,    -- Enable Jedi plugin
--           extra_path = {},   -- Optional: Additional paths for imports
--           references = true, -- Make sure references are enabled
--         },
--         -- Other plugins (optional)
--         pyflakes = { enabled = true },
--         pylint = { enabled = true },
--         pylsp_black = { enabled = true },
--         pylsp_isort = { enabled = true },
--       },
--     },
--   },
-- })
-- read :h vim.lsp.config for changing options of lsp servers
