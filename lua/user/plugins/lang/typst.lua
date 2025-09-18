vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { "*.typ" },
  callback = function(e)
    require('wrapping').soft_wrap_mode()
    local watch = function()
      local job = require('plenary.job')


      if vim.fn.executable("firefox") then
        local co = coroutine.create(function(url)
          job:new({
            command = "firefox",
            args = { "--new-window", url }
          }):start()
        end)

        local typst = job:new({
          command = "typst-live",
          args = { e.file, "--no-browser-tab" },
          on_stderr = function(_, data, _)
            for match in data:gmatch("%[INFO %] Server is listening on (.*)") do
              coroutine.resume(co, match)
            end
          end
        })
        typst:start()

        vim.api.nvim_create_autocmd("VimLeavePre", {
          callback = function()
            os.execute("pkill -TERM -P " .. typst.pid)
          end
        })


      else
        local typst = job:new({
          command = "typst-live",
          args = { e.file },
        })
        typst:start()

        vim.api.nvim_create_autocmd("VimLeavePre", {
          callback = function()
            typst:shutdown()
          end
        })
      end
    end
    vim.keymap.set("n", "<leader>lC", watch, { desc = "Watch", buffer = e.buf })
  end
})

return {
  recommended = {
    ft = "typ",
  },

  { "nvim-lua/plenary.nvim" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "typst" } },
  },

  { "andrewferrier/wrapping.nvim",
    opts = {
      notify_on_switch = false
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typst = { "typstyle" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },

}
