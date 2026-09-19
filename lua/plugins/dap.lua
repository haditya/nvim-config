return {
  -- =========================================================================
  -- 1. DAP Configuration (Reverted to your clean manual setups)
  -- =========================================================================
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Automatically open/close DAP UI like VS Code layouts
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

       -- =========================================================================
      -- CRITICAL BUGFIX: Disable exception breakpoints globally to stop the crash
      -- =========================================================================
      dap.defaults.fallback.exception_breakpoints = {}


      -- Python Debugging Setup (debugpy)
      dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
          local port = (config.connect or config).port
          local host = (config.connect or config).host or '127.0.0.1'
          cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python attach configuration'),
            host = host,
            options = { source_filetype = 'python' },
          })
        else
          cb({
            type = 'executable',
            command = 'python',
            args = { '-m', 'debugpy.adapter' },
            options = { source_filetype = 'python' },
          })
        end
      end

      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            if vim.fn.executable('.venv/bin/python') == 1 then
              return '.venv/bin/python'
            else
              return 'python'
            end
          end,
        },
      }

      -- Rust Debugging Setup (CodeLLDB) - SAFE RUNTIME RESOLUTION
      dap.adapters.codelldb = function(cb, config)
        local ok, mason_registry = pcall(require, "mason-registry")
        local codelldb_path = "codelldb" -- fallback string

        if ok and mason_registry.has_package("codelldb") then
          local package = mason_registry.get_package("codelldb")
          if package:is_installed() then
            codelldb_path = package:get_install_path() .. "/extension/adapter/codelldb"
          else
              vim.notify("Mason package 'codelldb' is not installed. Using system default.")
          end
        end

        cb({
          type = 'server',
          port = "${port}",
          executable = {
            command = codelldb_path,
            args = {"--port", "${port}"},
          }
        })
      end

      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
    end
  },
  {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
      },
      config = function()
        -- Initialize core mason first
        require("mason").setup()

        -- Configure the DAP installer
        require("mason-nvim-dap").setup({
          -- 1. List the debuggers you want automatically installed
          ensure_installed = { "codelldb" },
          -- 2. Tells the plugin to check and download missing debuggers on bootup
          automatic_installation = true,
          -- 3. Sets up standard handler bindings
          handlers = {
            function(config)
              require('mason-nvim-dap').default_setup(config)
            end,
          },
        })
      end
    },

  -- =========================================================================
  -- 2. Neotest Configuration (Reverted)
  -- =========================================================================
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Adapters
      "nvim-neotest/neotest-python",
      "mrcjkb/rustaceanvim", 
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justify = "debugpy" },
            runner = "pytest",
            -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test 
            -- instances for files containing a parametrize mark (default: false)
            pytest_discover_instances = true,
          }),
          require("rustaceanvim.neotest")
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = { open = false },
      })
    end
  }
}

