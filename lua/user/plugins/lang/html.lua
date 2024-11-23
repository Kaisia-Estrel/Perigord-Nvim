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
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        html = {
          cmd = { "vscode-html-language-server", "--stdio" }
        },
        cssls = {
          on_attach = function(_, _)
            vim.cmd.ColorizerAttachToBuffer()
          end,
        }
      }
    }
  },
}
