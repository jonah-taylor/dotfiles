return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = {
        ["<Tab>"]   = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"]    = { "accept", "fallback" },
        ["<C-e>"]   = { "hide" },
      },
      sources = {
        default = { "lsp", "buffer", "path", "snippets" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        list = { max_items = 5 },
        accept = { auto_brackets = { enabled = true } },
        ghost_text = { enabled = true },
        menu = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          draw = {
            gap = 2,
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 150,
          window = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:None",
          },
        },
      },
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
