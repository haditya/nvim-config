
-- ========================================================================== --
--                               1. SETTINGS                                  --
-- ========================================================================== --

-- Set <Space> as the leader key (Must be set BEFORE lazy.nvim loads)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
vim.opt.number = true          -- Show the line number your cursor is on
vim.opt.relativenumber = true  -- Show relative numbers for all other lines

-- UI & Search
vim.opt.termguicolors = true   -- Enable 24-bit RGB colors
vim.opt.ignorecase = true      -- Ignore case in search patterns
vim.opt.smartcase = true       -- Smart case searching (override ignorecase if uppercase is typed)
vim.opt.signcolumn = "yes"     -- Always show the sign column to prevent text shifting
vim.opt.scrolloff = 8          -- Keep at least 8 lines above/below cursor

-- Tabs & Indentation
vim.opt.tabstop = 4            -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4         -- Number of spaces used for autoindent
vim.opt.expandtab = true       -- Convert tabs to spaces
vim.opt.smartindent = true     -- Insert indents automatically

-- Disable netrw (built-in file explorer) to prevent conflicts with Neo-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1



-- ========================================================================== --
--                         2. PLUGINS (LAZY.NVIM)                             --
-- ========================================================================== --


-- Setup plugins
require("config.lazy")


-- ========================================================================== --
--                         3. KEYMAPS                                         --
-- ========================================================================== --
require("config.keymaps")

-- ========================================================================== --
--                         4. SETTINGS                                        --
-- ========================================================================== --
require("config.settings")
