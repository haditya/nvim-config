return {
  "folke/trouble.nvim",
  opts = {
    -- Automatically close the panel if it's the last window open
    auto_close = true,
    -- Auto-jump to the error position when clicking or opening an item
    auto_jump = true,
    -- Configure your preferred default visual views
    modes = {
      -- Workspace diagnostics (Every problem in your open directory)
      diagnostics = {
        mode = "diagnostics",
        filter = {
          -- Filter out virtual explorer buffers to keep lists clean
          ["not"] = { buftype = "nofile" },
        },
      },
      -- File diagnostics (Only problems inside your current active file tab)
      buffer_diagnostics = {
        mode = "diagnostics",
        filter = { buf = 0 }, 
      },
    },
    -- Visual icon sets matching common nerd fonts
    icons = {
      indent = {
        top = "│ ",
        middle = "├─ ",
        last = "└─ ",
        fold_open = " ",
        fold_closed = " ",
        ws = "  ",
      },
    },
  },
  keys = {
    -- Toggle Project Workspace Diagnostics Dashboard Panel
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics Dashboard (Project)",
    },
    -- Toggle Diagnostics for Current Document Buffer Only
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Diagnostics Dashboard (File)",
    },
    -- Open Quickfix Panel inside Trouble Window Layout
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
    -- Open Location List Panel inside Trouble Window Layout
    {
      "<leader>xl",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    -- Jump to NEXT problem anywhere in your layout (Great alternative to ]d)
    {
      "]x",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local card = vim.diagnostic.get_next()
          if card then vim.diagnostic.goto_next() end
        end
      end,
      desc = "Next Trouble/Diagnostic Item",
    },
    -- Jump to PREVIOUS problem anywhere in your layout (Great alternative to [d)
    {
      "[x",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          local card = vim.diagnostic.get_prev()
          if card then vim.diagnostic.goto_prev() end
        end
      end,
      desc = "Previous Trouble/Diagnostic Item",
    },
  },
}

