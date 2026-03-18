-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load global options and keymaps
require("custom.options")
require("custom.keymaps")

-- Collect all plugin specifications
local plugins = {}

-- 1. Load plugins from the custom/plugins/ directory
local plugins_path = vim.fn.stdpath("config") .. "/lua/custom/plugins"
local plugin_files = vim.fn.glob(plugins_path .. "/*.lua", true, true)
for _, file in ipairs(plugin_files) do
  local ok, spec = pcall(dofile, file)
  if ok and type(spec) == "table" then
    table.insert(plugins, spec)
  else
    vim.notify("Failed to load plugin: " .. file, vim.log.levels.ERROR)
  end
end

-- Setup lazy.nvim with all plugins
require("lazy").setup(plugins, {
  -- Optional lazy.nvim configuration (performance, UI, etc.)
})
