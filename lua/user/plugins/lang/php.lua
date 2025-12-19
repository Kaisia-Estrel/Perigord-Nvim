return {
  recommended = {
    ft = { "php" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "php")
    end
  },

  { "windwp/nvim-ts-autotag",
    opts = {}
  },

  { "gbprod/phpactor.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      install = {
        bin = vim.fn.exepath("phpactor")
      }
    }
  }

}
