
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Optional, but highly recommended for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- You can add custom configuration options inside setup()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true, -- Shows hidden files (e.g., .gitignore) by default
        },
         -- Forces files to open in your main text window rather than inside locked layouts
        open_files_in_last_window = true, 
        open_files_do_not_replace_types = { 
          "terminal", 
          "Trouble", 
          "trouble", 
          "qf", 
          "edgy", 
          "neotest-summary" -- 👈 Add this line
        },
        follow_current_file = {
          enabled = true, -- Focuses the active file in the tree automatically
        },
      },
    })
  end
}



