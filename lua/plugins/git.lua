local vim = vim



return {
  -- ==========================================
  -- GITSIGNS.NVIM
  -- ==========================================
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      current_line_blame = true, -- Toggle inline blame globally
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation through hunks
        map("n", "]h", function()
          if vim.wo.diff then return "]h" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Git Hunk" })

        map("n", "[h", function()
          if vim.wo.diff then return "[h" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous Git Hunk" })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Selected Hunk" })
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Selected Hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Entire Buffer" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Entire Buffer" })
        -- map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk Inline" })
        map("n", "<leader>hp", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Full Git Blame Pop-up" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff Current Buffer Against Index" })
        map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff Buffer Against Last Commit" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Inline Blame" })
      end,
    },
  },

  -- ==========================================
  -- DIFFVIEW.NVIM
  -- ==========================================
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diffview (Repo-wide)" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Git Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (Current Buffer)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Project Git History" },
    },
    opts = {
      enhanced_diff_hl = true, -- Better syntax highlighting in diff splits
      use_icons = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true, -- Turn off LSP errors during conflicts
        },
      },
    },
    keymaps = {
        view = {
          -- Navigate to the next and previous hunk using ]h and [h
          { "n", "]h", "]c", { desc = "Next hunk / change" } },
          { "n", "[h", "[c", { desc = "Previous hunk / change" } },
        },
        file_panel = {
          -- If you also want them to work while focusing the sidebar file list
          { "n", "]h", "]c", { desc = "Next hunk / change" } },
          { "n", "[h", "[c", { desc = "Previous hunk / change" } },
        },
      },
    hooks = {
      -- This hook guarantees right-side functionality by forcing buffer-local mappings
      view_opened = function(view)
        for _, win in ipairs(view.windows) do
          local buf = vim.api.nvim_win_get_buf(win)
          
          -- Force buffer-local overrides that take top priority over gitsigns/others
          vim.keymap.set("n", "]h", "]c", { buffer = buf, remap = false, desc = "Next hunk / change" })
          vim.keymap.set("n", "[h", "[c", { buffer = buf, remap = false, desc = "Previous hunk / change" })
        end
      end,
    },
  },
}

