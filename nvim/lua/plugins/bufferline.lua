return {
    'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  config = function()
    require('bufferline').setup({
      options = {
        -- Numbers on tabs without dots
        numbers = function(opts)
          return string.format('%s', opts.ordinal)
        end,
        -- Click to go to buffer
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,

        bufferline = {
            animation = true,
            scrollable = false,  -- Disable scrolling to force fitting
            auto_toggle_bufferline = false,
        },

        -- Appearance
        indicator = {
          icon = '▎',
          style = 'icon',
        },
        buffer_close_icon = '×',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',

        -- Layout - Force tabs to shrink dynamically
        max_name_length = 20,
        max_prefix_length = 15,
        tab_size = 10,  -- Let bufferline calculate size dynamically
        min_tab_width = 6,  -- Let it shrink as needed
        enforce_regular_tabs = true,  -- Allow dynamic sizing
        truncate_names = true,  -- Truncate long names to fit
        mode = "buffers",  -- Ensure we're in buffer mode (not tabs mode)
        diagnostics = false,
        show_buffer_icons = false,
        show_buffer_close_icons = false,  -- Remove close icons to save space
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,  -- Help distinguish similar names
        persist_buffer_sort = true,
        always_show_bufferline = true,

        -- -- Sidebar integration
        -- offsets = {
        --     {
        --     filetype = "NvimTree",
        --     text = "",
        --     text_align = "left"
        --     },
        --     {
        --         filetype = "neo-tree",
        --         text = "File Explorer", 
        --         highlight = "Directory",
        --         text_align = "left"
        --     }
        -- },

        -- Sorting
        sort_by = 'id',

        -- Custom filter
        custom_filter = function(buf_number, buf_numbers)
          -- Filter out filetypes you don't want to see
          local filetype = vim.bo[buf_number].filetype
          if filetype == "qf" then
            return false
          end
          return true
        end,
      },
        highlights = {
        -- fill = { bg = '#f1f1f1' },
        -- background = { bg = 'NONE', fg = 'NONE' },
        -- buffer_selected = { bg = 'NONE', fg = '#000000', bold = true },
        -- buffer_visible = { bg = 'NONE', fg = 'NONE', bold = false },
        -- separator = { bg = 'NONE', fg = 'NONE' },
        -- separator_selected = { bg = 'NONE', fg = 'NONE', bold = true },
        -- separator_visible = { bg = 'NONE', fg = 'NONE' },
        },
    })

    -- -- Force filler line transparency even after colorscheme reload
    -- vim.api.nvim_create_autocmd("ColorScheme", {
    -- pattern = "*",
    -- callback = function()
    --     vim.cmd("highlight BufferLineFill guibg=#000000")
    --     vim.cmd("highlight BufferLineBackground guibg=#000000")
    -- end,
    -- })


    -- Custom function to go to buffer by visual position
    local function go_to_buffer_by_position(pos)
      local bufferline = require('bufferline')
      local state = require('bufferline.state')

      -- Get the visible components
      if state.components and state.components[pos] then
        vim.cmd('buffer ' .. state.components[pos].id)
      end
    end

    local function delete_buffer_by_position(pos)
    local state = require('bufferline.state')
    if state.components and state.components[pos] then
        vim.cmd('bwipeout! ' .. state.components[pos].id)
        vim.cmd('redraw!')  -- Force a complete redraw
    end
    end

    -- Set up keybindings for all buffer positions
    for i = 1, 99 do
        vim.keymap.set('n', i .. '<CR>', function() go_to_buffer_by_position(i) end, 
            { desc = 'Go to buffer ' .. i, silent = true })
        vim.keymap.set('n', i .. 'c', function() delete_buffer_by_position(i) end, 
            { desc = 'Delete buffer ' .. i, silent = true })
    end
  end,

  keys = {
    { '<Tab>', '<Cmd>BufferLineCycleNext<CR>' },
    { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>' },
    { '<leader>cc', '<Cmd>bd<CR>' },
    
    -- Additional useful keybindings
    { '<leader>bp', '<Cmd>BufferLinePick<CR>' },
    { '<leader>bP', '<Cmd>BufferLinePickClose<CR>' },
    { '<leader>ca', '<Cmd>BufferLineCloseOthers<CR>' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>' },
    { '<leader>cmn', '<Cmd>BufferLineMoveNext<CR>' },
    { '<leader>cmp', '<Cmd>BufferLineMovePrev<CR>' },
  },
}
