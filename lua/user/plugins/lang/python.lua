return {
  recommended = {
    ft = "python",
    root = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "ninja")
      table.insert(opts.ensure_installed, "rst")
      table.insert(opts.ensure_installed, "python")
    end
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        ruff = {
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end
        },
        pylsp = {}
      },
    },
  },


}
