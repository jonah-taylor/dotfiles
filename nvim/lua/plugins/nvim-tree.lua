return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup({
      view = { side = "right" },
      git = {
        enable = false,
      },
      renderer = {
        icons = {
          show = {
            git = false,
          },
        },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "<CR>", function()
          local node = api.tree.get_node_under_cursor()
          local tree_win = vim.api.nvim_get_current_win()
          api.node.open.edit()
          if node and node.type == "file" and vim.api.nvim_win_is_valid(tree_win) then
            vim.api.nvim_set_current_win(tree_win)
          end
        end, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
          desc = "nvim-tree: Open (keep focus in tree)",
        })
      end,
    })
  end,
  keys = {
    { "<leader>d", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
  },
}
