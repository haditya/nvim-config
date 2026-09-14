return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- Explicitly tell lazy NOT to lazy-load treesitter
    lazy = false, 
    config = function()
      -- Directly trigger the updated config module layout
      local configs = require("nvim-treesitter.config")    
    configs.setup({
        -- Highlighting
        highlight = { enable = true },

        -- Smart Indentation
        indent = { enable = true },

        -- Visual Block Incremental Selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<bs>",
            node_decremental = "<bs>",
          },
        },
      })
      local parsers_to_install = { 
        "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "rust", "regex", "bash"
      }
      require("nvim-treesitter").install(parsers_to_install)
    end    },
  }



