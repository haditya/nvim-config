return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp", -- Ensures capabilities are ready
    },
    config = function()
      require("mason").setup()
      
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { 
          "lua_ls",         -- Lua
          "ruff",           -- Python (Linter)
          "omnisharp",      -- C#
          "clangd",         -- C / C++
        },
      })

      -- Grab capabilities natively provided by blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Global defaults for all native LSP servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Create an Autocommand group to ensure servers only fire up for real files
      local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
      
      -- FIX: Changed 'nvim_create_autocallback' to 'nvim_create_autocmd'
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        group = lsp_group,
        callback = function(args)
          -- Ignore virtual buffers like Neo-tree, telescope popups, or dashboard windows
          local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
          if buftype ~= "" then return end

          -- Detect cross-platform virtualenv binary paths (Unix 'bin' vs Windows 'Scripts')
          local is_windows = vim.uv.os_uname().sysname:find("Windows") ~= nil
          local bin_dir = is_windows and "/Scripts/" or "/bin/"
          local exe_ext = is_windows and "ty.exe" or "ty"

          local venv_path = vim.fn.getcwd() .. bin_dir .. exe_ext
          if vim.fn.filereadable(venv_path) == 0 then
            local alt_dir = is_windows and "venv/Scripts/" or "venv/bin/"
            venv_path = vim.fn.getcwd() .. "/" .. alt_dir .. exe_ext
          end

          local ty_cmd = vim.fn.filereadable(venv_path) == 1 and venv_path or "ty"

          -- Safely declare the custom 'ty' schema using the modern Neovim 0.11 API
          vim.lsp.config("ty", {
            cmd = { ty_cmd, "server" },
            root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git", "ty.toml" },
            filetypes = { "python" },
            settings = {
                ty = {
                    diagnosticMode = "workspace",
                },
            },
          })

          -- Safely enable all standard Mason servers on active buffers
          for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
            if server_name ~= "rust_analyzer" then
              pcall(vim.lsp.enable, server_name)
            end
          end

          -- Safely enable custom 'ty' server 
          pcall(vim.lsp.enable, "ty")
        end
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", 
    lazy = false,    
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.g.rustaceanvim = {
        server = {
          capabilities = capabilities,
          default_settings = {
            ['rust-analyzer'] = {
              checkOnSave = { command = "clippy" },
            },
          },
        },
      }
    end
  },
}

