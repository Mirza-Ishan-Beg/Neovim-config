return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- Use the stable, frozen branch
  lazy = false,      -- The plugin does not support lazy-loading [citation:1]
  build = ":TSUpdate", -- Command to update parsers after install/update
  opts = {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "gdscript", "lua", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {},

    -- Modules and their configurations
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    -- Text objects for navigation (your original request!)
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      },
    },
  },
  config = function(_, opts)
    -- This require will now work because we are on the 'master' branch
    require("nvim-treesitter.configs").setup(opts)
  end,
}
