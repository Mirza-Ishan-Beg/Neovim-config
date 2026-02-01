local map_opts = { noremap = true, silent = true }
local space = { 'n', 'i', 'v' }

-- MODULAR SYSTEM FROM NOW ON, GO TO ~/.config/nvim/lua/custom/..
--      The entire stuff is done in pcall to not break other stuff.
--      pcall is like try-except stuff. if something fails here
--      then it will stop working.
local ok, git_plugins = pcall(dofile, vim.fn.stdpath("config") .. "/lua/custom/git.lua")

if not ok then
    -- Python: except: print("Failed")
    vim.notify("Git config failed to load: " .. tostring(git_plugins), vim.log.levels.ERROR)
    git_plugins = {} -- Fallback so the rest of the config works
end

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 
vim.opt.expandtab = true 
vim.opt.softtabstop = 4 

-- Clears highlights AND the search register (the "clean slate")
vim.keymap.set('n', '<Esc><Esc>', ':let @/ = ""<CR>:noh<CR>', { silent = true })
-- Save file with Ctrl+S in Normal, Insert, and Visual modes
vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<cmd>update<cr><esc>', { desc = "Save file" })


vim.keymap.set('i', '<C-BS>', '<C-w>', map_opts)

vim.keymap.set('i', '<C-Del>', '<Esc>cvb', map_opts)

-- Arrow CTRL SHIFT combos selections --
vim.keymap.set(space, '<C-S-Left>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'i' then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>vb', true, false, true), 'n', false)
	elseif mode == 'v' or mode == 'V' or mode == '\22' then
		vim.cmd('normal! b')
	else
		vim.cmd('normal! vb')
	end
end, map_opts)

vim.keymap.set(space, '<C-S-Right>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'i' then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>ve', true, false, true), 'n', false)
	elseif mode == 'v' or mode == 'V' or mode == '\22' then
		vim.cmd('normal! e')
	else
		vim.cmd('normal! ve')
	end
end, map_opts)

vim.keymap.set(space, '<C-S-Up>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'i' then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>vk', true, false, true), 'n', false)
	elseif mode == 'v' or mode == 'V' or mode == '\22' then
		vim.cmd('normal! k')
	else
		vim.cmd('normal! vk')
	end
end, map_opts)

vim.keymap.set(space, '<C-S-Down>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'i' then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>vj', true, false, true), 'n', false)
	elseif mode == 'v' or mode == 'V' or mode == '\22' then
		vim.cmd('normal! j')
	else
		vim.cmd('normal! vj')
	end
end, map_opts)

vim.keymap.set(space, '<C-S-PageUp>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'i' then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>v<C-b>', true, false, true), 'n', false)
	elseif mode == 'v' or mode == 'V' or mode == '\22' then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-b>', true, false, true), 'n', false)
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('v<C-b>', true, false, true), 'n', false)
	end
end, map_opts)

vim.keymap.set(space, '<C-S-PageDown>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == 'i' then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>v<C-f>', true, false, true), 'n', false)
	elseif mode == 'v' or mode == 'V' or mode == '\22' then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-f>', true, false, true), 'n', false)
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('v<C-f>', true, false, true), 'n', false)
	end
end, map_opts)



-- ==============================================================

-- vim.keymap.set('v', '<C-S-c>', 'y', map_opts)

vim.keymap.set({'n', 'v'}, '<C-S-v>', 'p', map_opts)

vim.keymap.set('i', '<C-S-v>', '<C-r>+', map_opts)

-- Enable persistent undo
vim.opt.undofile = true

-- Specify the directory to store undo files
local myUndoDir = vim.fn.expand('~/.config/nvim/undodir')

-- Create the directory if it doesn't exist (optional, but recommended)
if vim.fn.isdirectory(myUndoDir) == 0 then
    vim.fn.system('mkdir -p ' .. myUndoDir)
end

vim.opt.undodir = myUndoDir

-- ==============================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo ({{ "Failed to clone lazy.nvim: \n" .. out, "ErrorMsg" }}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},

    -- 2. Modern LSP Setup (Neovim 0.11+ Standards)
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { 
                    "ts_ls", "pyright", "cssls", "html", 
                    "clangd", "bashls", "jdtls" 
                },
                -- 2026 Fix: Automatically enable servers using the new native API
                automatic_enable = true, 
            })

            -- Manual configuration for servers if needed
            -- vim.lsp.enable('pyright') -- This is now the standard way to start an LSP
        end,
    },

    -- 3. Autocomplete Engine (The "Menu" that pops up)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args) require("luasnip").lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer' },
                })
            })
        end,
    },
    spec = {
        git_plugins,
    }
})

