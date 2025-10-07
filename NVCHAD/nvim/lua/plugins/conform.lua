return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- assign formatters for real filetypes
      javascript = { "prettier" },
      typescript = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      lua = { "stylua" },
      -- dotenv / env files: empty = no formatting
      dotenv = {},
      sh = {}, -- optionally skip shell scripts if needed
    },
    -- optional: extra args for prettier
  },
}
