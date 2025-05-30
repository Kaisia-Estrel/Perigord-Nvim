return {
  { "rcarriga/nvim-dap-ui",
    opts = {},
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
  },
  { "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = { "rcarriga/nvim-dap-ui", "nvimtools/hydra.nvim", "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-dap.nvim" },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      local telescope = require("telescope")
      telescope.load_extension("dap")

      dap.listeners.after.event_initialized.dapui_config = dapui.open
      dap.listeners.after.event_terminated.dapui_config = dapui.close
      dap.listeners.after.event_exited.dapui_config = dapui.close

      for adapter, adapter_opts in pairs(opts.adapters or {}) do
        dap.adapters[adapter] = adapter_opts
      end

      for lang, lang_opts in pairs(opts.configurations or {}) do
        dap.configurations[lang] = lang_opts
      end


      local latte_palette = require("catppuccin.palettes").get_palette("latte")
      local palette = require("catppuccin.palettes").get_palette()

      local dap_opacity = 0.2

      local blend = require('user.util').blend

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = latte_palette.red, bg = palette.red })
      vim.api.nvim_set_hl(0, 'DapBreakpointLine', { bg = blend(palette.mantle, palette.maroon, dap_opacity) })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = latte_palette.blue, bg = palette.blue })
      vim.api.nvim_set_hl(0, 'DapLogPointLine', { bg = blend(palette.mantle, palette.lavender, dap_opacity) })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = latte_palette.green, bg = palette.green })
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = blend(palette.mantle, palette.teal, dap_opacity) })
      vim.fn.sign_define("DapBreakpoint",
        { text = "",
          texthl = "DapBreakpoint",
          linehl = "DapBreakpointLine",
          numhl = "DapBreakpoint" })

      vim.fn.sign_define("DapBreakpointCondition",
        { text = "",
          texthl = 'DapBreakpoint',
          linehl = 'DapBreakpointLine',
          numhl = 'DapBreakpoint' })

      vim.fn.sign_define("DapBreakpointRejected",
        { text = "",
          texthl = 'DapBreakpoint',
          linehl = 'DapBreakpointLine',
          numhl = 'DapBreakpoint' })

      vim.fn.sign_define("DapLogPoint",
        { text = "",
          texthl = 'DapLogPoint',
          linehl = 'DapLogPointLine',
          numhl = 'DapLogPoint' })

      vim.fn.sign_define("DapStopped",
        { text = "",
          texthl = "DapStopped",
          linehl = 'DapStoppedLine',
          numhl = 'DapStopped' })


      local hydra = require("hydra")
      local hydra_hints = [[
 Debug:
 
 _<C-p>_: Commands
 
 _K_: Step Back    _H_: Step Out
 _J_: Step Over    _L_: Step Into
 
 _b_:     Toggle Breakpoint
 _B_:     Create Conditional Breakpoint 
 _<A-b>_: Create Logpoint
 
 _<leader>v_: Variables
 _<leader>b_: Breakpoints
 _<leader>f_: Frames
 
  _n_:     Continue
 _<CR>_:   Start Debugging
 
 [_<Esc>_ | _q_]:   Close UI
 _<S-Esc>_: Terminate Session

      ]]

      local conditional_breakpoint = function()
        vim.ui.input({ prompt = "Condition: " }, function(input)
          dap.set_breakpoint(input)
        end)
      end

      local logpoint = function()
        vim.ui.input({ prompt = "Logpoint: " }, function(input)
          dap.set_breakpoint(nil, nil, input)
        end)
      end

      local debug_hydra = hydra({
        name = "Debug",
        hint = hydra_hints,
        config = {
          color = "pink",
          hint = {
            type = "window",
            float_opts = {
              border = "single",
            },
            title = "foo",
            position = "middle-right"
          },
          on_enter = dapui.open,
          on_exit = dapui.close,
        },
        heads = {
          { "J", dap.step_over, { desc = "Step Over" } },
          { "K", dap.step_back, { desc = "Step Back" } },
          { "H", dap.step_out, { desc = "Step Out" } },
          { "L", dap.step_into, { desc = "Step Into" } },
          { "n", dap.continue, { desc = "Continue" } },
          { "<CR>", dap.continue, { desc = "Start Debugging" } },
          { "<S-Esc>", dap.terminate, { desc = "Terminate Debug", exit = true } },
          { "<Esc>", nil, { exit = true } },
          { "q", nil, { exit = true } },
          { "B", conditional_breakpoint, { desc = "Create conditional breakpoint" } },
          { "<A-b>", logpoint, { desc = "Create Logpoint" } },
          { "<leader>v", telescope.extensions.dap.variables, { desc = "Variables" } },
          { "<leader>b", telescope.extensions.dap.list_breakpoints, { desc = "Breakpoints" } },
          { "<leader>f", telescope.extensions.dap.frames, { desc = "Frames" } },
          { "<C-p>", telescope.extensions.dap.commands, { desc = "Commands" } },
          { "b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" } },
        }
      })

      dap.listeners.after.event_initialized.dapui_config = function() debug_hydra:activate() end
      vim.keymap.set("n", "<leader>ld", function() debug_hydra:activate() end, { desc = "Debug" })
    end },
}
