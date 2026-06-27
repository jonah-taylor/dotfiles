return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    
    require("nvim-tree").setup({
      view = {
        side = "right",
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "BM",
            modified = "●",
            git = {
              unstaged = "+",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "",
              deleted = "-",
              ignored = "_",
            },
          },
        },
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        
        api.config.mappings.default_on_attach(bufnr)
        
        local function open_stay_in_tree()
          local node = api.tree.get_node_under_cursor()
          if node and node.type == "file" then
            api.node.open.edit()
            api.tree.focus()
          elseif node and node.type == "directory" then
            api.node.open.edit()
          end
        end
        
        vim.keymap.set('n', '<CR>', open_stay_in_tree, { buffer = bufnr, desc = "Open and stay in tree" })
        vim.keymap.set('n', '<2-LeftMouse>', open_stay_in_tree, { buffer = bufnr, desc = "Open and stay in tree" })
      end,
    })

    local function set_highlights()
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", {})
    local white = { fg = "#FFFFFF" }

    -- Icons
    vim.api.nvim_set_hl(0, "NvimTreeGitIcon", white)
    vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", white)
    vim.api.nvim_set_hl(0, "NvimTreeFileIcon", white)
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", white)
    vim.api.nvim_set_hl(0, "NvimTreeModifiedIcon", white)
    vim.api.nvim_set_hl(0, "NvimTreeExecFile", white)
    vim.api.nvim_set_hl(0, "NvimTreeSymlink", white)
    vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", white)

    -- Text
    vim.api.nvim_set_hl(0, "NvimTreeNormal", white)
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", white)
    vim.api.nvim_set_hl(0, "NvimTreeFileName", white)
    vim.api.nvim_set_hl(0, "NvimTreeFolderName", white)
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", white)
    vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", white)
    vim.api.nvim_set_hl(0, "NvimTreeSymlinkFolderName", white)
    vim.api.nvim_set_hl(0, "NvimTreeRootFolder", white)
    vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", white)

    -- Git status text
    vim.api.nvim_set_hl(0, "NvimTreeGitDirty", white)
    vim.api.nvim_set_hl(0, "NvimTreeGitStaged", white)
    vim.api.nvim_set_hl(0, "NvimTreeGitMerge", white)
    vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", white)
    vim.api.nvim_set_hl(0, "NvimTreeGitNew", white)
    vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", white)
    vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", white)

    -- Devicons
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
        local icons = devicons.get_icons()
        for _, icon in pairs(icons) do
        if icon.name then
            vim.api.nvim_set_hl(0, "DevIcon" .. icon.name, white)
        end
        end
    end
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = set_highlights,
    })

    vim.schedule(set_highlights)

    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local tree_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") then
            table.insert(tree_wins, w)
          end
        end
        if #wins == #tree_wins + 1 then
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
  keys = {
    { "<leader>d", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
  },
}
