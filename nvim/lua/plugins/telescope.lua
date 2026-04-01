return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", 
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        -- Ensure 'rg' (ripgrep) is used correctly for live_grep
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",          -- Search hidden files
          "--glob", "!**/.git/*", -- But ignore .git folder
        },
        prompt_prefix = "❯ ",
        selection_caret = "> ", -- Character for selected item
        entry_prefix = "  ",    -- MUST match the width of selection_caret
        path_display = { "truncate" },
        file_ignore_patterns = { 
          "node_modules",
          ".git/",
          "%.lock"
        },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<Tab>"] = "move_selection_next",
            ["<S-Tab>"] = "move_selection_previous",
          },
        },
      },
      pickers = {
        find_files = {
            theme = "dropdown",
            hidden = true, -- Also show hidden files in find_files
            previewer = false,
        },
        live_grep = {
          theme = "ivy",
            hidden = true,
        },
        buffers = {
          theme = "dropdown",
        },
      },
    })
  end,
  keys = {
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    -- { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    -- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    -- { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
    -- { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
    { "<leader>t", "<cmd>Telescope colorscheme<cr>", desc = "Choose Theme" },
  },
}
