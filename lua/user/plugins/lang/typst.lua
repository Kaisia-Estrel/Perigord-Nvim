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
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        tinymist = {
          settings = {
            formatterMode = "typstyle",
            exportPdf = "ontype"
          },

          on_attach = function(client, bufnr)
            require("wrapping").soft_wrap_mode()

            vim.keymap.set("n", "<leader>lp", function()
              client:exec_cmd({
                title = "pin",
                command = "tinymist.pinMain",
                arguments = { vim.api.nvim_buf_get_name(0) },
              }, { bufnr = bufnr })
            end, { desc = "Pin as mainfile", noremap = true })


            vim.keymap.set("n", "<leader>lW", function()
              local job = require("plenary.job")

              job:new({
                command = "typst",
                args = { "watch", vim.api.nvim_buf_get_name(bufnr) },
              }):start()

              vim.defer_fn(function()
                job:new({
                  command = "zathura",
                  args = { (vim.api.nvim_buf_get_name(bufnr):gsub("%.typ$", ".pdf")) }
                }):start()
              end, 200)
            end, { desc = "Watch", noremap = true })
          end
        }
      }
    }
  },
}
