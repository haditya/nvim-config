
-- ========================================================================== --
--                        HYBRID / TOGGLE LINE NUMBERS                        --
-- ========================================================================== --

local number_toggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

-- Switch to absolute numbers when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = number_toggle_group,
  pattern = "*",
  callback = function()
    vim.opt_local.relativenumber = false
  end,
})

-- Switch back to relative numbers when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = number_toggle_group,
  pattern = "*",
  callback = function()
    vim.opt_local.relativenumber = true
  end,
})




