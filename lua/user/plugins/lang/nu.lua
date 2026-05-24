return {
  recommended = {
    ft = { "nu" },
  },


  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "nu")
    end
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        nushell = {
          cmd = { "nu", "--lsp" },
        }
      }
    }
  }
}
