return {
  recommended = {
    ft = "cs",
    root = {
      "*.csproj",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "c_sharp")
    end
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        omnisharp = { 
          cmd = { "OmniSharp", "--languageserver", "--hostPID", vim.fn.getpid() }
        },
      },
    },
  }
}
