return {
  "rbong/vim-flog",
  dependencies = { "tpope/vim-fugitive" },
  config = function()
    vim.keymap.set("n", "<leader>gg", ":Flog<CR>", { desc = "Git Graph" })
    vim.keymap.set("n", "<leader>gs", ":G<CR>", { desc = "Git Status" })
  end,
}
