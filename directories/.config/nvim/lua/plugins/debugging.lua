return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "wojciech-kulik/xcodebuild.nvim", -- Used by setup_codelldb() below to set up codelldb and xcodebuild things
      "rcarriga/nvim-dap-ui",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
      { "<leader>dl", function() require("dap").list_breakpoints(true) end, desc = "Toggle REPL" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    },
    config = function ()
      require('utils.debuggers').setup_codelldb()
    end
  },
  -- TODO: setup Javascript and Typescript 
  -- @see https://github.com/mfussenegger/nvim-dap/wiki/Extensions#language-specific-extensions 
  -- @see https://github.com/mxsdev/nvim-dap-vscode-js

  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {},
  },

  -- The UI only gets opened as a result of the adapter firing an attach or launch event 
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function (_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end
  },
}
