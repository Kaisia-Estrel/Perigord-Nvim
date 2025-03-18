local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  recommended = {
    ft = { "css", "html", "scss" }
  },
  { "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "html")
      table.insert(opts.ensure_installed, "css")
    end
  },
  { "norcalli/nvim-colorizer.lua",
    opts = {
      css = { css = true }
    }
  },
  { "windwp/nvim-ts-autotag",
    opts = {}
  },
  { "MunifTanjim/prettier.nvim",
  },
  {
    "ray-x/web-tools.nvim",
    opts = {}
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        html = {
          cmd = { "vscode-html-language-server", "--stdio" },
          on_attach = function(_, bufnr)
            vim.keymap.set('n', "<leader>lw", "<cmd>BrowserPreview<cr>", { buffer = bufnr, desc = "Browser Preview" })
          end,
        },
        cssls = {
          capabilities = capabilities,
          on_attach = function(_, _)
            vim.cmd.ColorizerAttachToBuffer()
          end,
        }
      }
    }
  },
}
