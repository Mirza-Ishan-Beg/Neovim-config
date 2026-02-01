-- Return a list of plugins to be merged into the main setup
return {
  -- Git gutter signs
  { "lewis6991/gitsigns.nvim", config = true },

  -- Fugitive & Git Graph (Flog)
  { 
    "rbong/vim-flog", 
    dependencies = { "tpope/vim-fugitive" },
    config = function()
      -- Shortcuts inside the config block
      vim.keymap.set('n', '<leader>gg', ':Flog<CR>', { desc = "Git Graph" })
      vim.keymap.set('n', '<leader>gs', ':G<CR>', { desc = "Git Status" })
    end
  },

  -- Floating Terminal
  { 
    "akinsho/toggleterm.nvim", 
    version = "*", 
    opts = {
      open_mapping = [[<c-\>]], 
      direction = "float",
      float_opts = { border = "rounded" }
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      -- Terminal escape shortcut
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0 })
    end
  },
}

