local options = {
  -- provider = "gemini",
  behaviour = {
    auto_suggestions = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
  providers = {
    gemini = {
      model = "gemini-2.0-flash",
      temperature = 0,
      max_tokens = 4096,
    },
  },
}

require("avante").setup(options)
