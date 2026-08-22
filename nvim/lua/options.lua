
-- vim.cmd([[colorscheme gruvbox]])

vim.opt.clipboard = "unnamed,unnamedplus"

-- Disable swap files
vim.opt.swapfile = false

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber=true

-- Remove status line
vim.o.laststatus = 0

-- Timeout
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 500

-- Indenting and tabbing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.shiftround = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Show space chars
vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ', -- requires 2 chars
  space = '·',
  -- eol = ' ', -- once ↴
  trail = '~',
  extends = '»',
  precedes = '«',
  nbsp = '␣',
}

-- netwr
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
-- Use horizontal split (0), vertical (1), or current window (2) for file editing
vim.g.netrw_altv = 1
-- Set the location to the current buffer
vim.g.netrw_chgcti = 1 
vim.g.netrw_fastbrowse = 0

-- -- Errors
-- vim.opt.cmdheight = 1  -- More space for error messages (default is 1)
-- vim.keymap.set('n', '<leader>q', function()
--   vim.diagnostic.setqflist()
--   vim.cmd('copen')  -- Opens error list at bottom of screen
-- end, { desc = 'Show all errors' })
