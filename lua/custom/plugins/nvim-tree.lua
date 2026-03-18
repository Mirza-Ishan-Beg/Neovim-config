return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,                          -- load on startup (optional)
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      -- add your custom settings here
    })
    -- Optional keymap
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
  end,
}
