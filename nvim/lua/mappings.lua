-- Space only acts as leader
vim.keymap.set('n', '<space>', '<nop>', { noremap = true })

-- Consistent jumping
vim.keymap.set("n", "<C-u>", "16k")
vim.keymap.set("n", "<C-d>", "16j")

-- Quit
vim.cmd('cnoreabbrev wq wqa')
vim.cmd('cnoreabbrev q qa')

-- Visual mode: keep selection after indenting
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and reselect' })
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and reselect' })
vim.keymap.set('n', '\\h', '<cmd>nohl<cr>', { desc = "Clear search highlights" })

-- Lsp
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', '<leader>r', ':LspRestart<CR>', { desc = 'Restart LSP' })     
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
