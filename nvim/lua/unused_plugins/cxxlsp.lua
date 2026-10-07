-- return {
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       -- Configure LSP floating windows to wrap text
--         vim.lsp.handlers["textDocument/hover"] = function(bufnr, result, ctx, config)
--             config = config or {}
--             config.border = "rounded"
--             config.max_width = 80
--             config.max_height = 30

--             return vim.lsp.handlers.hover(bufnr, result, ctx, config)
--         end

--         vim.lsp.handlers["textDocument/signatureHelp"] = function(bufnr, result, ctx, config)
--             config = config or {}
--             config.border = "rounded"
--             config.max_width = 80
--         return vim.lsp.handlers.signature_help(bufnr, result, ctx, config)
--         end
      
--       -- Shared on_attach function for keymaps
--       local on_attach = function(client, bufnr)
--         local opts = { buffer = bufnr, noremap = true, silent = true }
        
--         -- Set up keymaps for LSP features
--         vim.keymap.set('n', '<leader>e', vim.lsp.buf.code_action, opts)
--         vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--         vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--         vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--         vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--       end
      
--       -- Configure clangd using vim.lsp.config
--       vim.lsp.config('clangd', {
--         cmd = {
--             "clangd", 
--             "--background-index=false",  -- Disable background indexing
--             "--header-insertion=never",
--             "--completion-style=bundled",
--             "--function-arg-placeholders=false",
--             "--clang-tidy=false",  -- Disable clang-tidy
--             "--cross-file-rename",
--         },
--         filetypes = {"c", "cpp", "objc", "objcpp"},
--         root_markers = {
--           'compile_commands.json',
--           'compile_flags.txt', 
--           '.clangd',
--           '.git',
--           'Makefile'
--         },
--         on_attach = function(client, bufnr)
--           client.server_capabilities.semanticTokensProvider = nil
--           on_attach(client, bufnr)
--         end
--       })

--         vim.diagnostic.config({
--             virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
--             signs = { severity = { min = vim.diagnostic.severity.ERROR } },
--             underline = { severity = { min = vim.diagnostic.severity.ERROR } },
--         })

--         -- Enable clangd
--         vim.lsp.enable('clangd')


--         vim.lsp.config('rust_analyzer', {
--             on_attach = on_attach,
--             settings = {
--                 ["rust-analyzer"] = {
--                     checkOnSave = true,
--                     check = {
--                         command = "clippy",
--                         extraArgs = { "--", "-A", "warnings" },
--                     },
--                     diagnostics = {
--                         enable = true,
--                         disabled = { "unresolved-proc-macro" },
--                         warningsAsHint = {},
--                     },
--                 },
--             },
--         })
--         vim.lsp.enable('rust_analyzer')

--       -- Configure Python LSP (pyright) using vim.lsp.config
--       vim.lsp.config('pyright', {
--         on_attach = on_attach,
--         settings = {
--           python = {
--             analysis = {
--               autoSearchPaths = true,
--               diagnosticMode = "workspace",
--               useLibraryCodeForTypes = true,
--               typeCheckingMode = "basic"  -- or "off", "basic", "strict"
--             }
--           }
--         }
--       })
      
--       -- Enable pyright
--       vim.lsp.enable('pyright')
      
--       -- Visual mode: keep selection after indenting
--       vim.keymap.set('v', '>', '>gv', { desc = 'Indent and reselect' })
--       vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and reselect' })
--       vim.keymap.set('n', '\\h', '<cmd>nohl<cr>', { desc = "Clear search highlights" })

--       -- Additional navigation mappings
--       vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
      
--       -- Set diagnostic highlight styles with colors
--       vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#ff0000' })
--       vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = '#ffff00' })
--       vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = '#00ffff' })
--       vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = '#0000ff' })

--       -- Configure diagnostics with wrapping
--       vim.diagnostic.config({
--         virtual_text = false,  -- Disable inline diagnostics
--         signs = true,          -- Keep signs in the gutter
--         underline = true,      -- Keep underlines
--         update_in_insert = true,
--         severity_sort = true,
--         float = {
--           wrap = true,
--           border = "rounded",
--           source = "always",
--           header = "",
--           prefix = "",
--           format = function(diagnostic)
--             return string.format("%s", diagnostic.message)
--           end,
--         },
--       })
      
--       -- Automatically show diagnostic float on cursor hold
--         vim.api.nvim_create_autocmd("CursorHold", {
--         callback = function()
--             local window_height = vim.api.nvim_win_get_height(0)
--             local cursor_screen_line = vim.fn.winline()
--             local in_top_half = cursor_screen_line <= (window_height / 2)

--             -- Get diagnostics at cursor
--             local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
--             if #diagnostics == 0 then return end

--             local lines = {}
--             local highlights = {}

--             for _, diagnostic in ipairs(diagnostics) do
--             -- Split multi-line messages into separate lines
--             local split_lines = vim.split(diagnostic.message, "\n", true)
--             for _, line_text in ipairs(split_lines) do
--                 table.insert(lines, line_text)

--                 -- Determine highlight group
--                 local hl_group
--                 if diagnostic.severity == vim.diagnostic.severity.ERROR then
--                 hl_group = "DiagnosticError"
--                 elseif diagnostic.severity == vim.diagnostic.severity.WARN then
--                 hl_group = "DiagnosticWarn"
--                 elseif diagnostic.severity == vim.diagnostic.severity.HINT then
--                 hl_group = "DiagnosticHint"
--                 else
--                 hl_group = "DiagnosticInfo"
--                 end

--                 table.insert(highlights, { line = #lines - 1, hl_group = hl_group })
--             end
--             end

--             -- Create floating buffer
--             local buf = vim.api.nvim_create_buf(false, true)
--             vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

--             -- Apply highlights
--             for _, hl in ipairs(highlights) do
--             vim.api.nvim_buf_add_highlight(buf, -1, hl.hl_group, hl.line, 0, -1)
--             end

--             local win_width = vim.api.nvim_win_get_width(0)
--             local float_width = math.min(80, win_width - 4)

--             local win_config = {
--             relative = "win",
--             width = float_width,
--             height = math.min(#lines, 10),
--             row = in_top_half and (window_height - math.min(#lines, 10) - 2) or 0,
--             col = 0,
--             style = "minimal",
--             border = "rounded",
--             focusable = false,
--             }

--             local float_win = vim.api.nvim_open_win(buf, false, win_config)

--             -- Close float on cursor move
--             vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" }, {
--             buffer = vim.api.nvim_get_current_buf(),
--             once = true,
--             callback = function()
--                 if vim.api.nvim_win_is_valid(float_win) then
--                 vim.api.nvim_win_close(float_win, true)
--                 end
--             end
--             })
--         end
--         })
--       vim.opt.updatetime = 250
--     end,
--   },
-- }
