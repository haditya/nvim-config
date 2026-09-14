return {
  -- blink.cmp: Performance-oriented autocompletion engine
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*", -- Use stable releases if you want pre-compiled binaries
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" }, -- Standard baseline sources
      },
    },
    opts_extend = { "sources.default" }
  }
}
