return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls", "basedpyright", "cssls", "html",
        "clangd", "bashls", "jdtls"
      },
      automatic_enable = true,
    })
    -- Additional per‑server config can go here
  end,
}
