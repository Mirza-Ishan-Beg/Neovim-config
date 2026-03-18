return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<c-\>]],
    direction = "float",
    float_opts = { border = "rounded" },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0 })
  end,
}
