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
    picker = {
      actions = {
        explorer_open_windows = function(_, item)
          if not item then
            return
          end

          local path = item.file:gsub("/", "\\")
          if item.dir then
            vim.fn.system(string.format('cmd /C start "" "%s"', path))
          else
            vim.fn.system(string.format('cmd /C explorer.exe /select,"%s"', path))
          end
        end,
      },
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["O"] = "explorer_open_windows",
              },
            },
          },
        },
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
