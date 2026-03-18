return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",               -- lazy-load on command
  config = function()
    -- Optional: set a keymap
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
  end,
}
