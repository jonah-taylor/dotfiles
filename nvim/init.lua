vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.scrolloff = 8
vim.o.scroll = 0

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = false },
  change_detection = {
    enabled = false,
    notify = false,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})

vim.cmd("syntax off")
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.treesitter.stop()
  end,

})

color = "#000000"

vim.api.nvim_set_hl(0, "Normal", { fg = color, bg = "#ffffea" })
vim.api.nvim_set_hl(0, "NormalNC", { fg = color, bg = "#ffffea" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#e0e0e0" })
vim.api.nvim_set_hl(0, "LineNr", { fg = color })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = color, bold = true })
vim.api.nvim_set_hl(0, "Visual", { bg = "#cccccc"})

vim.api.nvim_set_hl(0, "Search", { bg = "#f1f1f1", fg = color })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#cccccc", fg = color })
vim.api.nvim_set_hl(0, "CurSearch", { bg = "#888888", fg = "#ffffff" })

require("options")
require("mappings")
require("mania")

