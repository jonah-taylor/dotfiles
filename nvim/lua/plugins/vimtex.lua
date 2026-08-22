return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_mode = 0
  end,
  config = function()
    local base = vim.fn.expand("%:r")
    vim.g.vimtex_compiler_latexmk = {
      out_dir = base,
      options = {
        "-pdf",
        "-interaction=nonstopmode",
        "-synctex=1",
      },
    }
  end,
}
