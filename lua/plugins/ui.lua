return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons', -- Required for file type graphics
    after = 'catppuccin', -- Optional: ensures it inherits your theme properly
    config = function()
      -- Termguicolors must be enabled for full hex palette parsing
      vim.opt.termguicolors = true

      require('bufferline').setup({
        options = {
          mode = "buffers",               -- Manage open memory files as top tabs
          separator_style = "slant",     -- Tab shapes ("slant" | "slope" | "thick" | "thin")
          always_show_bufferline = true,  -- Keep it visible even with 1 file open
          show_buffer_close_icons = true,
          show_close_icon = false,
          
          -- Offset prevents tabs from overlapping sidebar explorers
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            }
          },
        }
      })

      -- Navigation Mappings
      vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
      vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
      vim.keymap.set('n', '<leader>c', '<cmd>bdelete<CR>', { desc = 'Close Current File' })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto', -- Automatically samples your active color scheme
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = { "alpha", "dashboard", "neo-tree" },
          },
          globalstatus = true, -- Unified bar even across vertical code splits
        },
        sections = {
          lualine_a = {'mode'},                        -- Normal / Insert / Visual
          lualine_b = {'branch', 'diff', 'diagnostics'}, -- Git details & LSP bugs
          lualine_c = {'filename'},                    -- File details
          lualine_x = {'encoding', 'filetype'},        -- File encoding & extension type
          lualine_y = {'progress'},                    -- Percentage position down file
          lualine_z = {'location'}                     -- Row : Column numbers
        },
      })
    end
  },
  {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        -- add any options here
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        },
      config = function()
          require("noice").setup({
              lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                  ["vim.lsp.util.stylize_markdown"] = true,
                  ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
              },
              -- you can enable a preset for easier configuration
              presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
              },
            })
      end,
    }
}



