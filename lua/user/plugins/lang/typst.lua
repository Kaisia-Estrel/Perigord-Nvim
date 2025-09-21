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

            local surround = function(delimStart, delimEnd)
              delimEnd = delimEnd or delimStart
              return function()
                local _, lstart, cstart, _ = unpack(vim.fn.getpos("v"))
                local line1 = vim.fn.getline(lstart)
                local new_line1 = line1:sub(1, cstart - 1) .. delimStart .. line1:sub(cstart)
                vim.fn.setline(lstart, new_line1)

                local _, lend, cend, _ = unpack(vim.fn.getpos("."))

                if lstart == lend then
                  cend = cend + string.len(delimStart)
                end
                local line2 = vim.fn.getline(lend)
                local new_line2 = line2:sub(1, cend) .. delimEnd .. line2:sub(cend + 1)
                vim.fn.setline(lend, new_line2)
              end
            end

            vim.keymap.set("v", "<C-b>", surround("*"), { expr = false })
            vim.keymap.set("v", "<C-i>", surround("_"), { expr = false })
            vim.keymap.set("v", "<C-`>", surround("`"), { expr = false })
            vim.keymap.set("v", "<C-u>", surround("#underline([", "])"), { expr = false })


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
