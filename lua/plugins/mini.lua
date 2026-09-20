return {
    'nvim-mini/mini.nvim', 
    version = false,
    config = function()
        vim.cmd('colorscheme tokyonight')

        -- require('mini.statusline').setup({})
        -- require('mini.tabline').setup({})

        require('mini.comment').setup({})
        require('mini.ai').setup({})
        require('mini.pairs').setup({})
        require('mini.surround').setup({})
        require('mini.align').setup({})
        -- require('mini.git').setup({})
        -- require('mini.diff').setup({})
        require('mini.animate').setup({
            -- You can customize animations here. Leaving it empty uses fast, clean defaults:
            cursor = { enable = true },
            scroll = { enable = true },
            resize = { enable = true },
            open   = { enable = true },
            close  = { enable = true },
          })


        require('mini.map').setup({})
        require('mini.starter').setup({})

        
    end
}
