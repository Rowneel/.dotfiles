return {
  "snacks.nvim",
  opts = {
    -- picker = { sources = { explorer = { layout = { layout = { width = 25 } } } } },
    dashboard = {
      preset = {
        header = [[
██████╗  ██████╗ ██╗    ██╗███╗   ██╗███████╗███████╗██╗     
██╔══██╗██╔═══██╗██║    ██║████╗  ██║██╔════╝██╔════╝██║     
██████╔╝██║   ██║██║ █╗ ██║██╔██╗ ██║█████╗  █████╗  ██║     
██╔══██╗██║   ██║██║███╗██║██║╚██╗██║██╔══╝  ██╔══╝  ██║     
██║  ██║╚██████╔╝╚███╔███╔╝██║ ╚████║███████╗███████╗███████╗
╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝
        ]],
      },
    },
  },
  keys = {
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
  },
}
-- opts.picker.sources.explorer.layout.layout.width = 10
