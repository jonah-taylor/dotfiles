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
        require("nvim-tree.api").config.mappings.default_on_attach(bufnr)
      end,
    })
  end,
  keys = {
    { "<leader>d", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
  },
}
