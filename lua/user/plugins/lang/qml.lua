return {
  recommended = {
    ft = { "qml" },
  },


  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "qml")
    end
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        qmlls = {
          cmd = { "qmlls", "-E" },
        }
      }
    }
  }
}
