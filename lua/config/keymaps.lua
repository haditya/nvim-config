-- ========================================================================== --
--                             2. KEYMAPS                                     --
-- ========================================================================== --
local vim = vim
-- Fast saving and exiting
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit Neovim" })

-- Delete currently open buffer
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Save file" })

-- Clear search highlights on pressing <Esc>
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Toggle Neo-tree (File Tree)
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-tree" })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep (Search text)" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
-- Fuzzy search through command-line history via Telescope
vim.keymap.set("n", "<leader>ch", require("telescope.builtin").command_history, { desc = "Search command history" })
-- View code outline via Treesitter in a fuzzy finder popup
vim.keymap.set("n", "<leader>co", require("telescope.builtin").treesitter, { desc = "Code Outline (Treesitter)" })

-- LSP Navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover information" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })


local dap = require("dap")
-- <leader>dc: Debug Continue (Matches F5)
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debug: Start/Continue" })
-- <leader>db: Debug Breakpoint (Matches F9)
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
-- <leader>do: Debug Over (Matches F10)
vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "Debug: Step Over" })
-- <leader>di: Debug Into (Matches F11)
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Debug: Step Into" })
-- <leader>dO: Debug Out (Matches Shift + F11)
vim.keymap.set("n", "<leader>dO", function() dap.step_out() end, { desc = "Debug: Step Out" })
-- <leader>dq: Debug Quit/Terminate (Matches Shift + F5)
vim.keymap.set("n", "<leader>dq", function() dap.terminate() end, { desc = "Debug: Stop Session" })





