vim.g.mapleader = " "

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
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})

vim.cmd("syntax off")
vim.cmd.colorscheme("monochrome")
vim.api.nvim_set_hl(0, "Normal", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "NormalNC", { fg = "#FFFFFF" })

local syntax_groups = {
  "Comment", "Constant", "String", "Character", "Number",
  "Boolean", "Float", "Identifier", "Function", "Statement",
  "Conditional", "Repeat", "Label", "Operator", "Keyword",
  "Exception", "PreProc", "Include", "Define", "Macro",
  "PreCondit", "Type", "StorageClass", "Structure", "Typedef",
  "Special", "SpecialChar", "Tag", "Delimiter", "SpecialComment",
  "Debug", "Underlined", "Error", "Todo",
}
for _, group in ipairs(syntax_groups) do
  vim.api.nvim_set_hl(0, group, { fg = "#FFFFFF" })
end

require("options")
require("mappings")
require("mania")

