return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  config = function()
    local ufo = require("ufo")

    -- Basic fold options
    vim.o.foldcolumn = "1" -- Show fold column
    vim.o.foldlevel = 99 -- Large value required by ufo
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Keymaps
    vim.keymap.set("n", "zR", ufo.openAllFolds)
    vim.keymap.set("n", "zM", ufo.closeAllFolds)
    vim.keymap.set("n", "zm", function()
      local n = vim.v.count
      if n == 0 then
        n = 0 -- default: close all folds
      end
      ufo.closeFoldsWith(n)
    end, { desc = "Close folds under cursor (use count for levels)" })
    vim.keymap.set("n", "zK", function()
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        -- choose one of coc.nvim or built-in LSP
        -- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
        vim.lsp.buf.hover() -- built-in LSP
      end
    end, { desc = "Peek Folded Line" })

    -- Provider selector: use treesitter first, then indent
    ufo.setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
    })

    -- Optional: setup LSP folding capability if you use built-in LSP
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    -- Apply to all active LSP clients
    for _, ls in ipairs(vim.lsp.get_clients()) do
      if ls.config then
        ls.config.capabilities = vim.tbl_deep_extend("force", ls.config.capabilities or {}, capabilities)
      end
    end
  end,
}
