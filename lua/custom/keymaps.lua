local map_opts = { noremap = true, silent = true }

-- Clear search highlights and search register
vim.keymap.set("n", "<Esc><Esc>", ':let @/ = ""<CR>:noh<CR>', { silent = true })

-- Save file with Ctrl+S in normal, insert, and visual modes
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>update<cr><esc>", { desc = "Save file" })

-- Insert mode: Ctrl+Backspace deletes word backward
vim.keymap.set("i", "<C-BS>", "<C-w>", map_opts)

-- (Optional) fix Ctrl+Del – currently broken; here's a sensible alternative:
-- vim.keymap.set("i", "<C-Del>", "<C-o>de", map_opts)  -- delete word forward

-- Paste from system clipboard
vim.keymap.set({ "n", "v" }, "<C-S-v>", "p", map_opts)       -- normal/visual paste
vim.keymap.set("i", "<C-S-v>", "<C-r>+", map_opts)           -- insert mode paste

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Use this to see why the line says W or E." })

